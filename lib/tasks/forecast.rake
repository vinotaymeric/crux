namespace :forecast do
  desc "Update forecast for basecamps"
  task update: :environment do
    UpdateForecast.new.update_mountain_ranges_cron
  end
end
