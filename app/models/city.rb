class City < ApplicationRecord
  geocoded_by :location, latitude: :coord_lat, longitude: :coord_long
  belongs_to :mountain_range, optional: true
  belongs_to :area, optional: true

  def clean_name
    self.name.encode("iso-8859-1").force_encoding("utf-8")
  end

  def meteoblue_air_url
    url = "https://www.meteoblue.com/fr/meteo/prevision/air/_france_#{self.geoname}"
    html_content = open(url).read
    doc = Nokogiri::HTML(html_content)
    meteoblue_15min_valid_path = doc.search('#blooimage').search('img').attr('data-original').value
    "https://#{meteoblue_15min_valid_path}"
  end

  def meteoblue_semaine_url
    url = "https://www.meteoblue.com/fr/meteo/prevision/semaine/_france_#{self.geoname}"
    html_content = open(url).read
    doc = Nokogiri::HTML(html_content)
    meteoblue_15min_valid_path = doc.search('.bloo_content').children[2].attr('data-original')
    "https://#{meteoblue_15min_valid_path}"
  end
end
