class Board < ApplicationRecord
  acts_as_paranoid

  belongs_to :user, required: true
  has_many :cards, dependent: :destroy
end
