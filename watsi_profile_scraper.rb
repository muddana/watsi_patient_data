require 'rubygems'
require 'nokogiri'         
require 'open-uri'
require 'open_uri_redirections'

def get_text(url)
	begin
		page = Nokogiri::HTML(open(url, :allow_redirections => :safe))   
		return page.css("div.real_writing").text
	rescue Exception => e
		return ""
	end
end

def determine_gender(text)
	# set initial male female word count
	mCount = 0; wCount = 0;
	words = text.gsub(".", " ").split(' ')
	#puts words
	words.each do |w|
		if w == "his" || w == "him" || w == "he" || w == "boy" || w == "man" || w == "male"
			mCount +=1;
		end
		if w == "her" || w == "she" || w == "girl" || w == "woman" || w == "female"
			wCount +=1;
		end
	end 
	#puts "Male Count   : " + mCount.to_s
	#puts "Female Count : " + wCount.to_s

	if mCount == wCount
		return ""
	else
		return ( mCount > wCount ) ? "M" : "F"
	end
end

#puts determine_gender( get_text("http://www.watsi.org/profile/4W0zh9Kc"))

if true
	urls = IO.readlines("watsi_patient_url.txt")

	#genderResults = Array.new()
	urls[1417,500].each do |u|
		puts determine_gender( get_text("https://watsi.org/profile/TTn1fNaj"))
		sleep(5)
	end
	#genderResults.each do |g|
	#	puts g
	#end
end