class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :user_activities, dependent: :destroy
  has_many :activities, through: :user_activities
  has_many :trips, dependent: :destroy
  has_many :invitations, through: :trips, dependent: :destroy
  has_many :follows, dependent: :destroy
  has_many :itineraries, through: :follows, dependent: :destroy
  has_many :participants, dependent: :destroy
  after_create :create_user_activities

  def create_user_activities
    return if self.guest == false
    # Return if guest user has already 'transmitted' it's user activities
    return if self.user_activities.where.not(level: nil).count > 1
    # Else create new blank user activities, for each activity
    Activity.all.each do |activity|
      UserActivity.create!(user: self, activity: activity)
    end
  end

  private

  def send_basecamp_email
    UserMailer.follow_basecamp(self).deliver_now
  end

end
