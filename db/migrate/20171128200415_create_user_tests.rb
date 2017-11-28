class CreateUserTests < ActiveRecord::Migration[5.1]
  def change
    create_table :user_tests do |t|
      t.belongs_to :user, index: true
      t.belongs_to :test, index: true
      t.integer :status, limit: 1
      t.integer :errors_count, default: 0
      t.timestamps
    end
  end
end
