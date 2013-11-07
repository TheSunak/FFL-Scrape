#!/usr/bin/env ruby

require 'nokogiri'
require 'open-uri'
require 'awesome_print'

class FflScraper
	
	attr_accessor :doc

	def initialize(url)
		@doc = Nokogiri::HTML(open(url))
	end

end

# total_records = doc.css('div.games-fullcol').css('table').css('tr').count        

#for row in 2..total_records-1
	# for col in 0..20
	#   ap pulled_row_data = doc.css('div.games-fullcol').css('table').css('tr')[2].css('td')[col].text  
	# end
#end

#########################
# Perform Data Analysis #
#########################

ffl = FflScraper.new("http://games.espn.go.com/ffl/leaders?leagueId=978650&teamId=1&scoringPeriodId=1&seasonId=2013")