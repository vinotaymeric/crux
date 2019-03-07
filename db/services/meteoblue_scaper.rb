# This service is used once to get city ids from meteoblue

require "open-uri"
require "nokogiri"

def pages_to_scan(parsed_html_page)
  # pages contain 120 items max
  max_items_per_page = 120
  if parsed_html_page.search('.totalcount').first.nil?
    return 1
  else
    return parsed_html_page.search('.totalcount').first.text.strip.to_i.fdiv(max_items_per_page).ceil
  end
end

def get_meteoblue_img_url(geoname_id)

  url = "https://www.meteoblue.com/fr/meteo/prevision/air/_france_#{geoname_id}"
  html_content = open(url).read
  doc = Nokogiri::HTML(html_content)
  meteoblue_15min_valid_path = doc.search('#blooimage').search('img').attr('data-original').value
  "https://#{meteoblue_15min_valid_path}"
  # doc.search('.result-title' && '.hdrlnk').each { |element| antiques << element.text.strip }
  # antiques
end

p get_meteoblue_img_url(2968984)
