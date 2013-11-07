#!/usr/bin/env ruby

require 'awesome_print'
require 'nokogiri'
require 'open-uri'

class FflScraper

	NUM_COL = 26
	REJECT  = [1,3,4,7,12,16,21,25]
	
	attr_reader :doc, :tot_rec

	def initialize(url)
		@doc 		 = Nokogiri::HTML(open(url))
		@tot_rec = doc.css('div.games-fullcol').css('table').css('tr').count - 1
	end

	def scrape
		(2..tot_rec).collect do |row|
			aggregate_col_data(row)
		end
	end

	def format_first_col(row)
		str = doc.css('div.games-fullcol').css('table').css('tr')[row].css('td')[0].text  
		
		name, str  = str.split(", ")
		team, posn = str.split(/\W/).reject(&:empty?)

		[name,team,posn]

	# Data may not be in standard form (e.g. ", ")
	rescue NoMethodError => e
		[str]
	end

	def aggregate_col_data(row)
		data_cols  = (1..NUM_COL).reject{|i| REJECT.include?(i)}.compact

		format_first_col(row)
			.concat(
				data_cols.collect do |col|
					doc.css('div.games-fullcol').css('table').css('tr')[row].css('td')[col].text  
				end).join(",")
	end

end

#for row in 2..total_records-1
	# for col in 0..20
	#   ap pulled_row_data = doc.css('div.games-fullcol').css('table').css('tr')[row].css('td')[col].text  
	# end
#end

#########################
# Perform Data Analysis #
#########################

ffl = FflScraper.new("http://games.espn.go.com/ffl/leaders?leagueId=978650&teamId=1&scoringPeriodId=1&seasonId=2013")
# ap ffl.aggregate_col_data(2)
ap ffl.scrape