class ChangeCardBodyColumnType < ActiveRecord::Migration[5.1]
  def change
    change_column(:cards, :body, :text)
  end
end
