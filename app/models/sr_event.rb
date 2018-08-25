class SrEvent < ApplicationRecord
  acts_as_paranoid

  belongs_to :user
  belongs_to :card

  after_create :set_send_sr_remind_job

  scope :filtered_by_card, -> (card_id) { where(card_id: card_id).order(:created_at) }
  scope :need_review,      -> { where(reviewed_at: nil).where("next_review_at < ?", Time.now) }

  def reviewed!
    self.touch(:reviewed_at)
  end
  private
  # everytime sr_event is created, we set SendSrRemindJob
  def set_send_sr_remind_job
    SendSrRemindJob.set(wait_until: self.next_review_at).perform_later(Card.find(self.card_id))
  end
end
