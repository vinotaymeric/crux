class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :user_activities, dependent: :destroy
  has_many :activities, through: :user_activities
  has_many :trips
  after_create :create_user_activities

  def create_user_activities
    p "tata"
    p self.user_activities.count
    p self
    p "toto" if self.user_activities.count > 0
    return if self.guest == false
    Activity.all.each do |activity|
      UserActivity.create!(user: self, activity: activity)
    end
  end

  private


  def send_basecamp_email
    UserMailer.follow_basecamp(self).deliver_now
  end

end
