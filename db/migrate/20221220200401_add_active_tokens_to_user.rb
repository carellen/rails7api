class AddActiveTokensToUser < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :active_tokens, :string, array: true, default: []
    add_index :users, :active_tokens, using: 'gin'
  end
end
