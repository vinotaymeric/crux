namespace :update_conditions do

  begin
    desc "Update BRA"
    task BRA: :environment do
      UpdateForecast.new.update_all_bra(Date.today.prev_day.to_s.delete("-").to_i)
    end

    desc "Update weather"
    task weather: :environment do
      UpdateWeather.new.update_weather
    end

    desc "Update itineraries scores"
    task itineraries: :environment do
      UpdateItinerary.new.update_itineraries_score
    end

    desc "Call C2C API for followed itineraries"
    task followed_itineraries: :environment do
      UpdateItinerary.new.update_outings_on_followed_itineraries
    end

    task all: [:BRA, :weather, :itineraries, :followed_itineraries]

  rescue StandardError => e
    p e.message
  end
end

desc "Update everything"
task update_conditions: "update_conditions:all"
