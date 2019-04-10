namespace :update_conditions do

  desc "Update BRA"
  task BRA: :environment do
    UpdateForecast.new.update_mountain_ranges_cron
  end

  desc "Update weather"
  task weather: :environment do
    UpdateForecast.new.update_weather
  end

  desc "Update itineraries scores"
  task itineraries: :environment do
    UpdateItinerary.new.update_itineraries_score
  end

  desc "Call C2C API for followed itineraries"
  task followed_itineraries: :environment do
    UpdateItinerary.new.update_outings_on_followed_itineraries
  end

end
