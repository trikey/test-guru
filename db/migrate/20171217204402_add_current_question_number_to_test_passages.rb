class AddCurrentQuestionNumberToTestPassages < ActiveRecord::Migration[5.1]
  def change
    add_column :test_passages, :current_question_number, :integer, default: 1
  end
end
