namespace :follow do
  desc "Update conditions for followes itineraries"
  task update: :environment do
    p "UPDATE FOLLOWED ITINERARIES"
    UpdateForecast.new.update_outings_on_followed_itineraries
  end
end
