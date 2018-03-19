class CreateSrEvents < ActiveRecord::Migration[5.1]
  def change
    create_table :sr_events, id: :uuid do |t|
      t.integer :interval
      t.integer :review_count
      t.datetime :next_review_at
      t.datetime :reviewed_at
      t.belongs_to :user, foreign_key: true, type: :uuid
      t.belongs_to :card, foreign_key: true, type: :uuid
      t.timestamps
      t.datetime :deleted_at
    end
  end
end
