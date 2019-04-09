class UserMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.user_mailer.follow_itinerary.subject
  #
  def alert(user, itinerary)
    @user = user
    @itinerary = itinerary
    mail(to: @user.email, subject: "Nouvelle sortie sur #{itinerary.name}")
  end
end
