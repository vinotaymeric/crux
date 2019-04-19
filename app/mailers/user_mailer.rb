include Rails.application.routes.url_helpers

class UserMailer < ApplicationMailer

  def alert(user, itinerary)
    @user = user
    @itinerary = itinerary
    mail(to: @user.email, subject: "Nouvelle sortie sur #{itinerary.name}")
  end

  def send_invitation(invitation)
    @invitation_link = invitation_link(invitation)
    mail(to: invitation.mailed_to, subject: "Rejoins ma sortie sur Crux")
  end

  private

  def invitation_link(invitation)
    root_url.chomp + trip_path(invitation.trip)[1..-1] + "?invitation_token=#{invitation.token}"
  end
end
