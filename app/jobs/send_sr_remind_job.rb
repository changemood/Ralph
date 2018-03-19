class SendSrRemindJob < ApplicationJob
  queue_as :mailers

  def perform(card)
    SrRemindMailer.remind(card).deliver_later
  end
end
