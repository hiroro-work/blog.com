class NoticeMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.notice_mailer.notify_admin_comment_added.subject
  #
  default from: "noreply@example.com"
  def notify_admin_comment_added(blog, entry, comment)
    @blog = blog
    @entry = entry
    @comment = comment
    mail(
      subject: "新しいコメントが投稿されました",
      to: "#{admin_mail}"
    ) do |format|
      format.text
    end
  end
end
