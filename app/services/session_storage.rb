class SessionStorage

  def initialize(objects)
    @objects = objects
  end

  def convert_to_hashes
    cities_array = []
    @objects.each do |city|
      cities_array << { "city_id" => city.id,
                             "nb_itineraries" => city.nb_itineraries,
                             "nb_good_itineraries" => city.nb_good_itineraries,
                             "temp_activity" => city.temp_activity,
                             "temp_score" => city.temp_score
                           }
    end
    cities_array
  end

  def convert_to_objects
    cities_array = []
    @objects.each do |city_activity|
      city = City.find(city_activity["city_id"])
      city.nb_itineraries = city_activity["nb_itineraries"]
      city.nb_good_itineraries = city_activity["nb_good_itineraries"]
      city.temp_activity = city_activity["temp_activity"]
      city.temp_score = city_activity["temp_score"]
      cities_array << city
    end
    cities_array
  end

end
