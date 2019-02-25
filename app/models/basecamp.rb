class Basecamp < ApplicationRecord
  belongs_to :activity, optional: true
  belongs_to :trip, optional: true
  belongs_to :itinerary, optional: true
end
