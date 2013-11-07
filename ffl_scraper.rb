#!/usr/bin/env ruby

require 'awesome_print'
require 'nokogiri'
require 'open-uri'

class FflScraper

	NUM_COL = 26
	REJECT  = [1,3,4,7,12,16,21,25]

	TEAM_NAMES = { "LOS" => "League of Shadows",
		"VD" => "Blow and Go", 
		"TheU" => "The Untouchables", 
		"GTL" => "The Galloping Guidos", 
		"V$" => "Show Me The V-Money". 
		"Soze" => "Keyser Soze", 
		"TSM" => "The Sugermen",
		"GF1" => "G Force 1",
		"Q" => "Vitamin Q",
		"FT" => "Foot Throat"}
	
	attr_reader :doc, :tot_rec

	def initialize(url)
		@doc 		 = Nokogiri::HTML(open(url))
		@tot_rec = doc.css('div.games-fullcol').css('table').css('tr').count - 1
	end

	# Scrape information across all relevant records.
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

	# Collect column information, formatting the first row.
	def aggregate_col_data(row)
		data_cols  = (1..NUM_COL).reject{|i| REJECT.include?(i)}.compact

		format_first_col(row)
			.concat(
				data_cols.collect do |col|
					doc.css('div.games-fullcol').css('table').css('tr')[row].css('td')[col].text  
				end).join(",")
	end

end

#########################
# Perform Data Analysis #
#########################

# Example call via command line:
#
# ruby ffl_scraper.rb ruby ffl_scraper.rb "http://games.espn.go.com/ffl/leaders?leagueId=978650&teamId=1&scoringPeriodId=1&seasonId=2013"

if ARGV.size == 1
	ffl = FflScraper.new(ARGV.first)
	ap ffl.scrape
else
	puts "Please enter a valid FFL URL for data entry."
end