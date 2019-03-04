require 'json'
require 'open-uri'
require "base64"

class UpdateForecast
  ## UPDATE BRA 
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

  def update_mountain_ranges_cron
    begin
    date = Date.today.prev_day.to_s.delete("-").to_i
    update_mountain_ranges(date)
    rescue Exception => e
      puts "bra_meteo_france indisponible "
    end
  end

  # BRA json keys all ranges per day
  def bra_per_day(date)
    date = date.to_i
    url = "https://donneespubliques.meteofrance.fr/donnees_libres/Pdf/BRA/bra.#{date}.json"
    JSON.parse(open(url).read)
  end 
  # variable globale 
  #bra_doc = bra_per_day(date)
  #p $bra_doc = bra_per_day(date)
  # ranges in the bra of meteo france per date
  def ranges(date)
    ranges =[]
    bra_doc = bra_per_day(date)
    bra_doc.each do |element|
      ranges << element["massif"]
    end 
    p ranges
  end 
  
  #bra_key
  def bra_key(range,date) 
    bra_doc = bra_per_day(date)
    bra_doc.each do |element|
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
    url ="https://donneespubliques.meteofrance.fr/donnees_libres/Pdf/BRA/BRA.#{bra_keys['massif']}.#{bra_keys['heures'].last}.xml"
    xml_noko_doc = xml_nokogiri_doc(url)
    #return bra_range_inf
      rosace = xml_noko_doc.xpath("//ImageCartoucheRisque ").text
      File.open("app/assets/images/rosace_#{bra_keys['massif']}.jpg", "wb") { |f| f.write(Base64.decode64(rosace)) }
      #put picture in cloudinary
      rosace_result =Cloudinary::Uploader.upload("app/assets/images/rosace_#{bra_keys['massif']}.jpg",
        :folder => "crux/images", :public_id => "rosace_#{bra_keys['massif']}", :overwrite => true, 
         :resource_type => "image")
      #rosace_image_url = "app/assets/images/rosace_#{bra_keys['massif']}.jpg"
       p rosace_image_url = rosace_result ["url"]

      # snow
      snow = xml_noko_doc.xpath("//ImageEnneigement").text
      File.open("app/assets/images/snow_#{bra_keys['massif']}.jpg", "wb") { |f| f.write(Base64.decode64(snow)) }
      #put picture in cloudinary
      snow_result = Cloudinary::Uploader.upload("app/assets/images/snow_#{bra_keys['massif']}.jpg",
        :folder => "crux/images", :public_id => "snow_#{bra_keys['massif']}", :overwrite => true, 
         :resource_type => "image")
      
     
        
      #recupérer la photo depuis cloudinary
      #snow_image_url = "app/assets/images/snow_#{bra_keys['massif']}.jpg"
      p snow_image_url = snow_result ["url"]

      #snow fraiche
      fresh_snow = xml_noko_doc.xpath("//ImageNeigeFraiche").text
      File.open("app/assets/images/fresh_snow_#{bra_keys['massif']}.jpg", "wb") { |f| f.write(Base64.decode64(fresh_snow)) }
        #put picture in cloudinary
      fresh_snow_result= Cloudinary::Uploader.upload("app/assets/images/fresh_snow_#{bra_keys['massif']}.jpg",
          :folder => "crux/images", :public_id => "fresh_snow_#{bra_keys['massif']}", :overwrite => true, 
           :resource_type => "image")
     
      #recupérer la photo depuis cloudinary  
      #fresh_snow_image_url = "app/assets/images/fresh_snow_#{bra_keys['massif']}.jpg"
      p fresh_snow_image_url = fresh_snow_result ["url"]
      
      bra_range_inf = {
        range_name: bra_keys['massif'],
        bra_date_validity: xml_noko_doc.xpath("//DateValidite ").text,
        resume: xml_noko_doc.xpath("//RESUME ").text,
        stability: xml_noko_doc.xpath('//STABILITE').text,
        snow_quality: xml_noko_doc.xpath('//QUALITE').text,
        rosace_image_url: rosace_image_url,
        snow_image_url: snow_image_url,
        fresh_snow_image_url: fresh_snow_image_url
      }
      return bra_range_inf
  end
  
  # bra all ranges per date 
  def bra_all_ranges_per_date(date)
    bra_all_ranges = []
    ranges(date).each do |range|
        bra_all_ranges << bra_per_range(bra_key(range,date))   
    end
      bra_all_ranges
  end 
  
  #bra par range 
  def bra_per_range_per_date(range,date)
    bra_keys = bra_key(range,date)
    bra_per_range(bra_key(range,date))
  end 
  
  
  #update mountain ranges
  def update_mountain_ranges(date)
    bra_ranges = bra_all_ranges_per_date(date)
    bra_ranges.each do |bra_range|
      moutain_range_to_update = MountainRange.where(name: bra_range[:range_name])
        moutain_range_to_update.each do |m|
          p " #{m.name} updated"
          m.bra_date = date
          m.rosace_url = bra_range[:rosace_image_url]
          m.fresh_snow_url = bra_range[:fresh_snow_image_url]
          m.snow_image_url = bra_range[:snow_image_url]
          m.snow_quality = bra_range[:snow_quality]
          m.stability = bra_range[:stability]
          m.save!
        end
    end
  end
  ##### END UPDATE BRA ########
  
  ##### UPADATE WEATHER  ####
  def api_call(lat, lon)
    #url = "https://api.apixu.com/v1/forecast.json?key=3a0aef724b764f6cb35161705192702&q=#{lat},#{lon}&days=7"
    p ENV['WEATHER_KEY']
   p url = "https://api.apixu.com/v1/forecast.json?key=#{ENV['WEATHER_KEY']}&q=#{lat},#{lon}&days=7"
    JSON.parse(open(url).read)
  end

  def update_weather
    Weather.all.each do |weather|
      begin
      basecamp = weather.basecamp
      weather_hash = api_call(basecamp.coord_lat, basecamp.coord_long)
      score = 0
      weather_hash["forecast"]["forecastday"].each do |day|
        day_hash = day["day"]
        score += day_hash["avgtemp_c"].to_i + day_hash["avgvis_km"].to_i - day_hash["maxwind_kph"].to_i - day_hash["totalprecip_mm"].to_i
      end
      weather.weekend_score = score
      weather.forecast = weather_hash["forecast"]["forecastday"]
      weather.save!
  
      # Adding a rescue so that it works even a call fails
      rescue Exception => e
      puts "#weather {weather.id} a pété"
      end
    end
  end
  ## END UPDATE WEATHER ##

  # def addPictureToCloudinary(type)
  #   Cloudinary::Uploader.upload("app/assets/images/#{type}_#{bra_keys['massif']}.jpg",
  #     :folder => "crux/images", :public_id => "#{type}_#{bra_keys['massif']}.jpg", :overwrite => true, 
  #      :resource_type => "image")
  # end 
end