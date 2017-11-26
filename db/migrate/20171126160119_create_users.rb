class CreateUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :users do |t|
      t.string :name, null: false
      t.string :last_name
      t.string :email, null: false
      t.string :password, null: false
      t.integer :permission, null: false

      t.timestamps
    end
  end
end
