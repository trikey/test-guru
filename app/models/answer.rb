class Answer < ApplicationRecord
  belongs_to :question

  scope :correct, -> { where(correct: true) }

  validates :body, presence: true
  validate :validate_answers

  def validate_answers
    errors.add(:question, 'there can be no more than 4 answers') if question.answers.count >= 4
  end
end
