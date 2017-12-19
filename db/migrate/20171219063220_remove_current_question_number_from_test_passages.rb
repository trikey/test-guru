class RemoveCurrentQuestionNumberFromTestPassages < ActiveRecord::Migration[5.1]
  def change
    remove_column :test_passages, :current_question_number, :integer
  end
end
