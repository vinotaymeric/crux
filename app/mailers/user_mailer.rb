class UserMailer < ApplicationMailer

  def alert(user, itinerary)
    @user = user
    @itinerary = itinerary
    mail(to: @user.email, subject: "Nouvelle sortie sur #{itinerary.name}")
  end
end
