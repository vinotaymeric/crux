class CitiesController < ApplicationController

  def index
    @user = current_or_guest_user
    @trip = Trip.find(params[:trip_id])
    @one_hour_polygon = @trip.isochrone_coordinates
    find_top_cities

    # Mapbox
    @markers = @cities.map do |city|
      {
        lng: city.coord_long,
        lat: city.coord_lat,
        infoWindow: render_to_string(partial: "infowindow", locals: {city: city, trip: @trip}),
        image_url: "https://res.cloudinary.com/dbehokgcg/image/upload/v1553264629/#{city.temp_activity}.png",
      }
    end
    # Add trip start location
    @markers << {
        lng: @trip.coord_long,
        lat: @trip.coord_lat,
        image_url: helpers.asset_url('https://cdn1.iconfinder.com/data/icons/business-sets/512/target-512.png'),
    }
  end

  private

  def score(city, trip)
    # Compute subscores
    itinerary_score = [city.nb_good_itineraries - 1, 0].max
    weather_score = city.weather.score(trip.start_date, trip.end_date)

    if city.included_in_polygon?(@one_hour_polygon)
      distance_score = 1
    else
      distance_score = 1 + trip.distance_from(city) / 50
    end
    # Return final score
    ([weather_score, [(itinerary_score / 2), trip.duration].min].min) / distance_score ** (1.05 - trip.duration / 20)
  end

  def find_top_cities
    if session[:cities_activities].nil? || session[:cities_activities].empty?
      cities_activities = []
      @trip.trip_activities.each do |trip_activity|
        next if trip_activity.level == "Niveau ?" || trip_activity.level.nil?
        activity = trip_activity.activity

        city_activity = City.select("cities.*, SUM(itineraries.score) as nb_good_itineraries_from_query, COUNT(itineraries.id) as nb_itineraries_from_query")
        .joins(:itineraries)
        .where(itineraries: {activity_id: activity.id, universal_difficulty: trip_activity.level.downcase })
        .group("cities.id HAVING SUM(itineraries.score) > 0")
        .order("nb_good_itineraries_from_query")

        city_activity.each do |city|
          city.temp_activity = activity.name
          city.nb_itineraries = city.nb_itineraries_from_query
          city.nb_good_itineraries = city.nb_good_itineraries_from_query
        end

        cities_activities << city_activity
      end

      # Order by score
      cities_activities.flatten!
      cities_activities.sort_by! do |city_activity|
        city_activity.temp_score = score(city_activity, @trip)
        [city_activity.temp_score, - @trip.distance_from(city_activity)]
      end
      # Take only top 18 and send them to the view
      @cities = cities_activities.reverse[0..13]
      # Store them in session to avoid long reloads
      session[:cities_activities] = SessionStorage.new(@cities).convert_to_hashes
    else
      @cities = SessionStorage.new(session[:cities_activities]).convert_to_objects
    end
  end
end
