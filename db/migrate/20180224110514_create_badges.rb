class CreateBadges < ActiveRecord::Migration[5.1]
  def change
    create_table :badges do |t|
      t.string :name
      t.string :path
      t.integer :rule_id

      t.timestamps
    end
    add_index :badges, :name
  end
end
