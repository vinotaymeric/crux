class UpdateItinerary
  # Update all scores without getting data from outside
  def update_itineraries_score
    Itinerary.all.each do |itinerary|
      begin
      itinerary.update!(score: itinerary.score_calculation)
      puts "iti #{itinerary.id} updated"
      rescue Exception => e
        p e.message
      end
    end
  end

  # Get extra data trough C2C API for followed itineraries, send emails
  def send_alert_to_each_user(itinerary)
    users_with_alerts = User.joins(:itineraries).where(itineraries: {id: itinerary.id})
    users_with_alerts.each do |user|
      UserMailer.alert(user, itinerary).deliver
    end
  end

  def update_outings_on_followed_itineraries
    Follow.itineraries.uniq.each do |itinerary|
      itinerary.update_recent_conditions
      sleep(0.5)
      send_alert_to_each_user(itinerary) unless itinerary.recent_outings(2).empty?
    end
  end
end
