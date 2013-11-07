#!/usr/bin/env ruby

#------------------------------------- TO RUN PROGRAM-----------------
#
# In terminal: ruby checking_for_box.rb > results.xls
# 
# This will send the output of the script to the XLS with the results
#
#--------------------------------------------------------------------


#Require these Gems
require 'nokogiri'
require 'open-uri'

    #-------jQuery that got the hrefs to each of the company pages from ------------------------
    #http://money.cnn.com/magazines/fortune/fortune500/2013/full_list/index.html?iid=F500_sp_full

    # $("#f500-list > #content-placeholder > li> a").each(function(index,value){
    #     console.log($(this).attr('href'));
    # });  
    #-------------------------------------------------------------------------------------------


#This variable contents the sub-pages for each company on the Fortune 500 list, we will use this array to 
#open each of these addresses and find the website address
week_test = "http://games.espn.go.com/ffl/leaders?leagueId=978650&teamId=1&scoringPeriodId=1&seasonId=2013"
total_records = doc.css('div.games-fullcol').css('table').css('tr').count        

        #Open the URL in Nokogiri:
        doc = Nokogiri::HTML(open(week_test))

        #This line gets the website address based on the <div class = snapUniqueData> on each page
        #p pulled_website_name = doc.css('div.games-fullcol').css('table').css('tr')[2].text

         p pulled_website_name = doc.css('div.games-fullcol').css('table').css('tr').count



