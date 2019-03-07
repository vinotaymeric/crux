namespace :forecast do
  desc "Update forecast for basecamps"
  task update: :environment do
    p "UPDATE BRA RANGES"
    p "ranges to upadate"
    p "BRA DATE:#{Date.today.prev_day}"
    UpdateForecast.new.update_mountain_ranges_cron
    p "UPDATE BRA RANGES END"
    p "UPDATE WEATHER"
    #UpdateForecast.new.update_weather
    p "UPDATE WEATHER AND BRA  END"
  end
end
