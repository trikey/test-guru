class CreateRules < ActiveRecord::Migration[5.1]
  def change
    create_table :rules do |t|
      t.string :name
      t.string :rule_type
      t.integer :rule_value, null: true

      t.timestamps
    end
  end
end
