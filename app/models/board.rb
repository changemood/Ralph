class Board < ApplicationRecord
  belongs_to :user, required: true

  default_scope { where(deleted_at: nil).order(created_at: :desc) }
end
