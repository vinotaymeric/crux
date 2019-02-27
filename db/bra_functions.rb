
require 'json'
require 'open-uri'
require 'date'
require 'nokogiri'
require 'pry'
require "base64"

# RANGES =["VANOISE","ASPE-OSSAU","AURE-LOURON","HAUTE-BIGORRE","PAYS-BASQUE","CINTO-ROTONDO","RENOSO-INCUDINE","ARAVIS",
#   "CHABLAIS","MONT-BLANC","BELLEDONNE","CHARTREUSE","GRANDES-ROUSSES","OISANS","VERCORS","ANDORRE","CAPCIR-PUYMORENS",
#   "CERDAGNE-CANIGOU","COUSERANS","HAUTE-ARIEGE","ORLU__ST_BARTHELEMY","CHAMPSAUR","DEVOLUY","EMBRUNAIS-PARPAILLON",
#  "HAUT-VAR_HAUT-VERDON","MERCANTOUR","PELVOUX","QUEYRAS","THABOR","UBAYE","BAUGES","BEAUFORTAIN","HAUTE-MAURIENNE","HAUTE-TARENTAISE",
#  "MAURIENNE",
#  ]

# bra de toutes les massifs le : date
def bra_per_day(date)
  # convertir la date au format yearmonthday(integer)
  date = date.to_i
  url = "https://donneespubliques.meteofrance.fr/donnees_libres/Pdf/BRA/bra.#{date}.json"
  JSON.parse(open(url).read)
end 

# ranges in the bra of meteo france per date
def ranges(date)
  ranges =[]
  bra_doc = bra_per_day(date)
  bra_doc.each do |element|
     element
    ranges << element["massif"]
  end 
 ranges
end 

#bra_key
def bra_key(range,date) 
 bra_doc = bra_per_day(date)
 bra_doc.each do |element|
    element
   #return element if element["massif"]== range 
   if element["massif"]== range
     return element
   else
     "range not exist ! "
   end
 end
end

# nokogiri xml
def xml_nokogiri_doc(url)
    bra_range_xml = open(url).read
    xml_noko_doc =  Nokogiri::XML(bra_range_xml)
end

#
def bra_per_range(bra_keys={})
  ap url ="https://donneespubliques.meteofrance.fr/donnees_libres/Pdf/BRA/BRA.#{bra_keys['massif']}.#{bra_keys['heures'].last}.xml"
  xml_noko_doc = xml_nokogiri_doc(url)
  #return bra_range_inf
   rosace = xml_noko_doc.xpath("//ImageCartoucheRisque ").text
   File.open("app/assets/images/rosace_#{bra_keys['massif']}.jpg", "wb") { |f| f.write(Base64.decode64(rosace)) }
   rosace_image_url = "app/assets/images/rosace_#{bra_keys['massif']}.jpg"
  

   # snow
   snow = xml_noko_doc.xpath("//ImageEnneigement").text
   File.open("app/assets/images/snow_#{bra_keys['massif']}.jpg", "wb") { |f| f.write(Base64.decode64(snow)) }
   snow_image_url = "app/assets/images/snow_#{bra_keys['massif']}.jpg"
   
   #snow fraiche
   fresh_snow = xml_noko_doc.xpath("//ImageNeigeFraiche").text
   File.open("app/assets/images/fresh_snow_#{bra_keys['massif']}.jpg", "wb") { |f| f.write(Base64.decode64(fresh_snow)) }
   fresh_snow_image_url = "app/assets/images/fresh_snow_#{bra_keys['massif']}.jpg"

   bra_range_inf = {
     range_name: bra_keys['massif'],
     bra_date_validity: xml_noko_doc.xpath("//DateValidite ").text,
     resume: xml_noko_doc.xpath("//RESUME ").text,
     stability: xml_noko_doc.xpath('//STABILITE').text,
     snow_quality: xml_noko_doc.xpath('//QUALITE').text,
    #  risque: xml_noko_doc.xpath("//RISQUE ")[0].to_a
     rosace_image_url: rosace_image_url,
     snow_image_url: snow_image_url,
     fresh_snow_image_url: fresh_snow_image_url
   }
   return bra_range_inf
 end
  
def bra_all_ranges_per_date(date)
  bra_all_ranges = []
  ranges = ranges(date)
  ranges.each do |range|
      bra_all_ranges << bra_per_range(bra_key(range,date))   
  end
  bra_all_ranges
end 

#bra par range 
def bra_per_range_per_date(range,date)
  bra_keys = bra_key(range,date)
  bra_per_range(bra_key(range,date))
end 
