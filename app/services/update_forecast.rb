require 'json'
require 'open-uri'
require 'base64'
require_relative 'services_helpers'

class UpdateForecast

  # MeteoFrance provides a JSON with all BRA keys (= ways to access XML) for a given date
  def get_bra_keys_for(date)
    url = "https://donneespubliques.meteofrance.fr/donnees_libres/Pdf/BRA/bra.#{date}.json"
    JSON.parse(open(url).read)
  end

  # For a given range / BRA, we can get the information trough an XML file
  def get_bra_info_for_this_range(bra_keys)
    url ="https://donneespubliques.meteofrance.fr/donnees_libres/Pdf/BRA/BRA.#{bra_keys['massif']}.#{bra_keys['heures'].last}.xml"
    xml_data = Nokogiri::XML(open(url).read)

    rosace = xml_data.xpath("//ImageCartoucheRisque ").text
    snow = xml_data.xpath("//ImageEnneigement").text
    fresh_snow = xml_data.xpath("//ImageNeigeFraiche").text

    # Get other info and return everything trough a hash
      {range_name: bra_keys['massif'],
      bra_date_validity: xml_data.xpath("//DateValidite ").text,
      resume: xml_data.xpath("//RESUME ").text,
      stability: xml_data.xpath('//STABILITE').text,
      snow_quality: xml_data.xpath('//QUALITE').text,
      rosace_image_url: upload_image("rosace", rosace, bra_keys["massif"]) ["url"],
      snow_image_url: upload_image("snow", snow, bra_keys["massif"]) ["url"],
      fresh_snow_image_url: upload_image("fresh_snow", fresh_snow, bra_keys["massif"]) ["url"],
      max_risk: xml_data.xpath("//RISQUE /@RISQUEMAXI ").first.value.to_i}
  end

  # We can thus update all BRA for ranges we have in our database
  def update_all_bra(date)
    bra_keys = get_bra_keys_for(date)

    bra_keys.each do |bra_key|
      begin
        bra = get_bra_info_for_this_range(bra_key)
        mountain_range = MountainRange.where(name: bra[:range_name])[0]
        mountain_range.update!(
          bra_date: date,
          rosace_url: bra[:rosace_image_url],
          fresh_snow_url: bra[:fresh_snow_image_url],
          snow_image_url: bra[:snow_image_url],
          snow_quality: bra[:snow_quality],
          stability: bra[:stability],
          max_risk: bra[:max_risk]
        )
        p "#{mountain_range.name} updated"
      rescue Exception => e
        p e.message
      end
    end
  end

end
