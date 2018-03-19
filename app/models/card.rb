class Card < ApplicationRecord
  belongs_to :user, required: true
  belongs_to :board, required: false
  has_many :sr_events, dependent: :destroy

  default_scope { where(deleted_at: nil).order(created_at: :desc) }
end
