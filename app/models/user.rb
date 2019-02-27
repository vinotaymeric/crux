class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :user_activities, dependent: :destroy
  has_many :activities, through: :user_activities
  has_many :trips

  after_create :create_user_activities

  private

  def create_user_activities
    Activity.all.each do |activity|
      UserActivity.create!(user: self, activity: activity)
      # self.user_activities.create!(activity: activity)
    end
  end
end
