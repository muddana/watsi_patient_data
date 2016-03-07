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

	words.each do |w|
		if w == "his" || w == "him" || w == "he" || w == "boy" || w == "boys" || w == "man" || w == "male"
			mCount +=1;
		end
		if w == "her" || w == "she" || w == "girl" || w == "girls" || w == "woman" || w == "female" || w == "daughter"
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

puts determine_gender( get_text("https://watsi.org/profile/571f2fd8bc5a"))

if false
	urls = IO.readlines("watsi_patient_url.txt")
	#puts urls.size
	#genderResults = Array.new()
	urls.each do |u|
		puts determine_gender( get_text(u) )
		sleep(4)
	end
	#genderResults.each do |g|
	#	puts g
	#end
end