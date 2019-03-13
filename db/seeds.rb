require 'json'
require 'open-uri'
require 'nokogiri'

ItineraryJson.delete_all

puts "Seeding Itineraries..."

def api_call(itinerary, id)
  url = "https://api.camptocamp.org/#{itinerary}/#{id.to_s}"
  p url
  JSON.parse(open(url).read)
end

sitemap0 = Nokogiri::HTML(open("https://www.camptocamp.org/sitemaps/r/0.xml"))
sitemap1 = Nokogiri::HTML(open("https://www.camptocamp.org/sitemaps/r/1.xml"))
itinerary_ids = []

sitemap0 = Nokogiri::HTML(open("https://www.camptocamp.org/sitemaps/r/0.xml"))
sitemap1 = Nokogiri::HTML(open("https://www.camptocamp.org/sitemaps/r/1.xml"))
itinerary_ids = []

sitemap0.xpath("//loc").each do |url|
  itinerary_ids << url.to_s.split("/")[4]
end

sitemap1.xpath("//loc").each do |url|
  itinerary_ids << url.to_s.split("/")[4]
end

p itinerary_ids

itinerary_ids.each do |id|
  begin
  itinerary_hash = api_call("routes", id)
  iti_json = ItineraryJson.new(json: itinerary_hash.to_s)
  iti_json.save!
  rescue Exception => e
  p "id #{id} a pété"
  end
  sleep(1)
end

