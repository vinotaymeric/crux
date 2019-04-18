class Invitation < ApplicationRecord
  belongs_to :trip
  validates :mailed_to, presence: true, format: { with: /.+@.+\..+/i, message: "email incorrect"}
end
