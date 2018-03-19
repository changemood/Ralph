# Preview all emails at http://localhost:3000/rails/mailers/sr_remind_mailer
class SrRemindMailerPreview < ActionMailer::Preview

  # Preview this email at http://localhost:3000/rails/mailers/sr_remind_mailer/remind
  def remind
    SrRemindMailerMailer.remind
  end

end
