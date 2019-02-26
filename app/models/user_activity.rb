class UserActivity < ApplicationRecord
  belongs_to :user
  belongs_to :activity
  validates :level, presence: true
end
