require 'nokogiri'
require 'open-uri'


urls = []
search_list = ["isb hyderabad", "football", "manchester united", "hollywood trailer", "amazing tennis", "radical something", "Just for Laugh"]
search_list.each do |search_term|

  #list_url = "http://www.youtube.com/watch?v=m10xcPcuBeg"
  list_url = "http://www.youtube.com/results?search_query=#{search_term.split(' ').join('+')}"

  page = Nokogiri::HTML(open (list_url))

  p '-------------------------------------------------------------------------'
  p "finding videos for #{search_term}"
  div_elements = page.css('li.yt-lockup2 a')

  div_elements.each do |d|
    watch_code = d.attributes['href'].value
    urls << "http://www.youtube.com" + watch_code if watch_code.include?('watch')
  end
end

p 'the links are'
p urls
p 'total videos found'
p urls.count

p '---------------download start -----------------------------------------------'
urls.each do |link_to_video|
  system("youtube-dl -t #{link_to_video}")
end
p '---------------download completed-------------------------------------------'

