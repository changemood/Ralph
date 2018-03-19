class SrRemindMailer < ApplicationMailer
  default from: 'remind@ralphs.com'

  def remind(card)
    @card = card
    @user = User.find(card.user_id)
    mail(
      to: @user.email,
      subject: "Time to review #{card.title}",
    ) do |format|
      format.html
    end
  end
end
