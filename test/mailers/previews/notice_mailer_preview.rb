# Preview all emails at http://localhost:3000/rails/mailers/notice_mailer
class NoticeMailerPreview < ActionMailer::Preview

  # Preview this email at http://localhost:3000/rails/mailers/notice_mailer/notify_admin_comment_added
  def notify_admin_comment_added
    NoticeMailer.notify_admin_comment_added
  end

end
