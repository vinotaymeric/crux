# Preview all emails at http://localhost:3000/rails/mailers/user_mailer
class UserMailerPreview < ActionMailer::Preview

  # Preview this email at http://localhost:3000/rails/mailers/user_mailer/follow_itinerary
  def follow_basecamp
    user = User.last
    UserMailer.follow_basecamp(user)
  end

end
