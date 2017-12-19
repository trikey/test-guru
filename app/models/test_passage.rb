class TestPassage < ApplicationRecord
  enum status: { passing: 1, passed_with_errors: 2, passed: 3 }

  belongs_to :user
  belongs_to :test
  belongs_to :current_question, class_name: 'Question', optional: true

  scope :passing, -> { where(status: status[:passing]) }

  before_validation :before_validation_set_first_question, on: :create
  before_update :next_question, on: :update

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

  private

  def correct_answer?(answer_id)
    Answer.find(answer_id).correct
  end

  def next_question
    self.current_question = test.questions.order(:number).where('number > ?', current_question.number).first
  end

  def before_validation_set_first_question
    self.current_question = test.questions.first
  end
end
