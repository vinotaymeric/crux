class TripActivity < ApplicationRecord
  belongs_to :trip, optional: true
  belongs_to :activity
end
