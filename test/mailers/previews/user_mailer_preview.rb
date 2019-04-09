# Preview all emails at http://localhost:3000/rails/mailers/user_mailer
class UserMailerPreview < ActionMailer::Preview

  # Preview this email at http://localhost:3000/rails/mailers/user_mailer/follow_itinerary
  def alert
    user = User.last
    UserMailer.alert(user, Itinerary.find(35468))
  end

end
