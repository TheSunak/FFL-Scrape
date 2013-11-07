#!/usr/bin/env ruby

require 'nokogiri'
require 'open-uri'

week_url = "http://games.espn.go.com/ffl/leaders?leagueId=978650&teamId=1&scoringPeriodId=1&seasonId=2013"

doc = Nokogiri::HTML(open(week_url))

total_records = doc.css('div.games-fullcol').css('table').css('tr').count        

#for row in 2..total_records-1
    for col in 0..20

        p pulled_row_data = doc.css('div.games-fullcol').css('table').css('tr')[2].css('td')[col].text
        
    end


#end
