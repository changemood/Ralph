class AddAncestryToCards < ActiveRecord::Migration[5.1]
  def change
    add_column :cards, :ancestry, :text
    add_index :cards, :ancestry
  end
end
