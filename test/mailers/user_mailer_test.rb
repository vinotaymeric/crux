require 'test_helper'

class UserMailerTest < ActionMailer::TestCase
  test "follow_itinerary" do
    mail = UserMailer.follow_itinerary
    assert_equal "Follow itinerary", mail.subject
    assert_equal ["to@example.org"], mail.to
    assert_equal ["from@example.com"], mail.from
    assert_match "Hi", mail.body.encoded
  end

end
