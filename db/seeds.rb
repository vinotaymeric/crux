require 'json'
require 'open-uri'
require 'nokogiri'
require 'addressable/uri'


def api_call(itinerary, id)
  url = "https://api.camptocamp.org/#{itinerary}/#{id.to_s}"
  p url
  JSON.parse(open(url).read)
end

def recent_conditions(itinerary)
  itinerary = Addressable::URI.encode_component(itinerary.name, Addressable::URI::CharacterClasses::QUERY)
  url_c2C = "https://www.google.fr/search?ei=8gmBXLvLGOCCjLsPsf2_gAo&q=site%3Ahttps%3A%2F%2Fwww.camptocamp.org%2Froutes%2F+#{itinerary}+&oq=site%3Ahttps%3A%2F%2Fwww.camptocamp.org%2Froutes%2F+#{itinerary}"

  html_file_c2C = open(url_c2C).read
  html_doc_c2c = Nokogiri::HTML(html_file_c2C)

  id = html_doc_c2c.search('h3').first.children.attribute('href').value.split("/")[5].to_i

  p api_call("outings", id)["associations"]["recent_outings"]["total"]
end

recent_conditions(Itinerary.find(347))


# url_skitour = "https://www.google.fr/search?ei=PQ2BXO3vKo3jgweYlavQCA&q=site%3Ahttp%3A%2F%2Fwww.skitour.fr%2Ftopos%2F+#{itinerary}&oq=site%3Ahttp%3A%2F%2Fwww.skitour.fr%2Ftopos%2F+#{itinerary}"
# html_file_skitour = open(url_skitour).read
# html_doc_skitour = Nokogiri::HTML(html_file_skitour)
