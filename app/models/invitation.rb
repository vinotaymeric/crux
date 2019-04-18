class Invitation < ApplicationRecord
  after_create :send_invitation

  belongs_to :trip
  validates :mailed_to, presence: true, format: { with: /.+@.+\..+/i, message: "email incorrect"}

  private

  def send_invitation
    UserMailer.send_invitation(self).deliver_now
  end
end
