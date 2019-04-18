class Invitation < ApplicationRecord
  before_create :generate_token
  after_create :send_invitation

  belongs_to :trip
  validates :mailed_to, presence: true, format: { with: /.+@.+\..+/i, message: "email incorrect"}

  private

  def send_invitation
    UserMailer.send_invitation(self).deliver_now
  end

  def generate_token
     self.token = Digest::SHA1.hexdigest([trip.id, Time.now, rand].join)
  end
end
