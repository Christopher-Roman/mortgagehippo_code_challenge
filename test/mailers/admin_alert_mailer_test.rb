require 'test_helper'

class AdminAlertMailerTest < ActionMailer::TestCase
  test "coins_low" do
    mail = AdminAlertMailer.coins_low
    assert_equal "Coins low", mail.subject
    assert_equal ["to@example.org"], mail.to
    assert_equal ["from@example.com"], mail.from
    assert_match "Hi", mail.body.encoded
  end

end
