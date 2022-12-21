class AddDeletedAtToLists < ActiveRecord::Migration[7.0]
  def change
    add_column :lists, :deleted_at, :datetime
    add_index :lists, :deleted_at
  end
end
