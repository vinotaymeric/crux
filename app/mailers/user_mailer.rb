include Rails.application.routes.url_helpers

class UserMailer < ApplicationMailer

  def alert(user, itinerary)
    @user = user
    @itinerary = itinerary
    mail(to: @user.email, subject: "Nouvelle sortie sur #{itinerary.name}")
  end

  def send_invitation(invitation)
    @trip = invitation.trip
    mail(to: invitation.mailed_to, subject: "Rejoins ma sortie sur Crux")
  end
end
