class CreateUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :users do |t|
      t.string :first_name, null: false
      t.string :last_name
      t.string :email, null: false
      t.string :password, null: false
      t.string :password_confirmation, null: false
      t.integer :permission, null: false

      t.timestamps
    end
  end
end
