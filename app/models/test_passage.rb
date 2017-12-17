class TestPassage < ApplicationRecord
  PASSING = 1
  PASSED = 3
  PASSED_WITH_ERRORS = 2

  belongs_to :user
  belongs_to :test
  belongs_to :current_question, class_name: 'Question', optional: true

  scope :passing, -> { where(status: PASSING) }

  before_validation :before_validation_set_first_question, on: :create

  def accept!(answer_id)
    self.correct_questions += 1 if correct_answer?(answer_id)
    self.current_question = next_question
    save!
  end

  def completed?
    current_question.nil?
  end

  private

  def correct_answer?(answer_id)
    true if Answer.find(answer_id).correct
    false
  end

  def next_question
    test.questions.order(:id).where('id > ?', current_question.id).first
  end

  def before_validation_set_first_question
    self.current_question = test.questions.first
  end
end
