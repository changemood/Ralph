class Card < ApplicationRecord
  belongs_to :user, required: true
  belongs_to :board, required: false

  default_scope { where(deleted_at: nil).order(created_at: :desc) }
end
