require 'json'
require 'open-uri'
require 'nokogiri'
require 'addressable/uri'
require 'date'




p Itinerary.find(382).recent_conditions

# url_skitour = "https://www.google.fr/search?ei=PQ2BXO3vKo3jgweYlavQCA&q=site%3Ahttp%3A%2F%2Fwww.skitour.fr%2Ftopos%2F+#{itinerary}&oq=site%3Ahttp%3A%2F%2Fwww.skitour.fr%2Ftopos%2F+#{itinerary}"
# html_file_skitour = open(url_skitour).read
# html_doc_skitour = Nokogiri::HTML(html_file_skitour)
