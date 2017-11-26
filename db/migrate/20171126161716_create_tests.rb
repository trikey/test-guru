class CreateTests < ActiveRecord::Migration[5.1]
  def change
    create_table :tests do |t|
      t.string :title, null: false
      t.integer :level, null: false, default: 1
      t.references :category, foreign_key: true, null: false

      t.timestamps
    end
  end
end
