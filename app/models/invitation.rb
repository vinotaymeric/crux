class Invitation < ApplicationRecord
  before_create :generate_token
  after_create :send_invitation

  belongs_to :trip
  validates :mailed_to, presence: true, format: { with: /\A([\w+\-].?)+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i, message: "email incorrect"}

  private

  def send_invitation
    UserMailer.send_invitation(self).deliver_now
  end

  def generate_token
     self.token = Digest::SHA1.hexdigest([trip.id, Time.now, rand].join)
  end
end
