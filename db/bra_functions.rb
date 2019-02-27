
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

#  RANGES=[
#   ["ARAVIS",14417,45.846413,6.334947],
#   ["CHABLAIS",14411,46.318140,6.626145],
#   ["MONT-BLANC",14410,45.883301,6.777260],
#   ["BELLEDONNE",14398,45.285310,6.083845],
#   ["CHARTREUSE",14401,45.391632,5.829542],
#   ["GRANDES-ROUSSES",14407,45.103830,6.158032],
#   ["OISANS",14403,44.906325,6.048607],
#   ["VERCORS",14459,44.985566,5.444291],
#   ["CHAMPSAUR",44.738119,6.211661],
#   ["DEVOLUY",14402,44.711481,5.856499],
#   ["EMBRUNAIS-PARPAILLON",14433,44.556136,6.498148],
#   ["HAUT-VAR_HAUT-VERDON",44.125274,6.888620],
#   ["MERCANTOUR",14466,44.099146,7.404649],
#   ["PELVOUX",44.846494,6.453069],
#   ["QUEYRAS",14432,44.777821,6.774239],
#   ["THABOR",252522,45.030848,6.587581],
#   ["UBAYE",14433,44.427467,6.693337],
#   ["BAUGES",14399,45.656268,6.117206],
#   ["BEAUFORTAIN",14400,45.646010,6.591681],
#   ["HAUTE-MAURIENNE",45.251245,6.945459],
#   ["HAUTE-TARENTAISE",45.502243,6.934307],
#   ["MAURIENNE",45.290803,6.311035],
#   ["VANOISE",45.354104,6.594064]
#   ]


RANGES=[
["ARAVIS",14417,45.846413,6.334947],
["CHABLAIS",14411,46.318140,6.626145],
["MONT-BLANC",14410,45.883301,6.777260],
["BELLEDONNE",14398,45.285310,6.083845],
["CHARTREUSE",14401,45.391632,5.829542],
["GRANDES-ROUSSES",14407,45.103830,6.158032],
["OISANS",14403,44.906325,6.048607],
["VERCORS",14459,44.985566,5.444291],
["CHAMPSAUR",0,44.738119,6.211661],
["DEVOLUY",14402,44.711481,5.856499],
["EMBRUNAIS-PARPAILLON",14433,44.556136,6.498148],
["HAUT-VAR_HAUT-VERDON",0,44.125274,6.888620],
["MERCANTOUR",14466,44.099146,7.404649],
["PELVOUX",0,44.846494,6.453069],
["QUEYRAS",14432,44.777821,6.774239],
["THABOR",252522,45.030848,6.587581],
["UBAYE",14433,44.427467,6.693337],
["BAUGES",14399,45.656268,6.117206],
["BEAUFORTAIN",14400,45.646010,6.591681],
["HAUTE-MAURIENNE",0,45.251245,6.945459],
["HAUTE-TARENTAISE",0,45.502243,6.934307],
["MAURIENNE",0,45.290803,6.311035],
["VANOISE",0,45.354104,6.594064]
]
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



