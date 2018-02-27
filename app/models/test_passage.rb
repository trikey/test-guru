class TestPassage < ApplicationRecord
  enum status: { passing: 1, passed_with_errors: 2, passed: 3 }

  belongs_to :user
  belongs_to :test
  belongs_to :current_question, class_name: 'Question', optional: true, inverse_of: :test_passages

  scope :passing, -> { where(status: status[:passing]) }

  before_save :before_save_set_current_question

  def accept!(answer_id)
    self.correct_questions += 1 if correct_answer?(answer_id)
    save!
  end

  def completed?
    current_question.nil?
  end

  def correct_answers_percent
    (correct_questions * 100 / test.questions.count).round
  end

  def time_left
    (test.time * 60) - (Time.current.to_i - created_at.to_i)
  end

  private

  def correct_answer?(answer_id)
    Answer.find(answer_id).correct
  end

  def before_save_set_current_question
    return self.current_question = test.questions.order(:number).first if current_question.nil?
    self.current_question = test.questions.order(:number).find_by('number > ?', current_question.number)
  end
end
