class AddDeletedAtToListItems < ActiveRecord::Migration[7.0]
  def change
    add_column :list_items, :deleted_at, :datetime
    add_index :list_items, :deleted_at
  end
end
