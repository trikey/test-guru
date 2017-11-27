class CreateQuestions < ActiveRecord::Migration[5.1]
  def change
    create_table :questions do |t|
      t.text :body, null: false
      t.references :test, foreign_key: true, null: false

      t.timestamps
    end
  end
end
