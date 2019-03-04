class UserMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.user_mailer.follow_itinerary.subject
  #
  def follow_basecamp(user)
    @user = user
    mail(to: @user.email, subject: 'Infos camps de base')
  end
end
