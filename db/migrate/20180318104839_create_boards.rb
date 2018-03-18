class CreateBoards < ActiveRecord::Migration[5.1]
  def change
    create_table :boards, id: :uuid do |t|
      t.string :name
      t.datetime :deleted_at
      t.belongs_to :user, foreign_key: true, type: :uuid
      t.timestamps
    end
  end
end
