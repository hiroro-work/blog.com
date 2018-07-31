require 'test_helper'

class NoticeMailerTest < ActionMailer::TestCase
  test "notify_admin_comment_added" do
    mail = NoticeMailer.notify_admin_comment_added
    assert_equal "Notify admin comment added", mail.subject
    assert_equal ["to@example.org"], mail.to
    assert_equal ["from@example.com"], mail.from
    assert_match "Hi", mail.body.encoded
  end

end
