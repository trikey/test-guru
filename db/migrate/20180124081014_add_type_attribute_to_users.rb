class AddTypeAttributeToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :type, :string, null: false, default: 'User'
    add_index :users, :type
  end
end
