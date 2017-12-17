class ChangeUsersTestsToTestPassages < ActiveRecord::Migration[5.1]
  def change
    rename_table :user_tests, :test_passages
    add_column :test_passages, :correct_questions, :integer, default: 0
    add_reference :test_passages, :current_question, references: :questions, foreign_key: { to_table: :questions }
  end
end
