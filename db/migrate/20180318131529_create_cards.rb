class CreateCards < ActiveRecord::Migration[5.1]
  def change
    create_table :cards, id: :uuid do |t|
      t.string :title
      t.string :body
      t.belongs_to :board, foreign_key: true, type: :uuid
      t.belongs_to :user, foreign_key: true, type: :uuid
      t.timestamps
      t.datetime :deleted_at
    end
  end
end
