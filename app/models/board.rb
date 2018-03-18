class Board < ApplicationRecord
  belongs_to :user, required: true
  has_many :cards, dependent: :destroy
  default_scope { where(deleted_at: nil).order(created_at: :desc) }
end
