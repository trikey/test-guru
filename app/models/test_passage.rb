class TestPassage < ApplicationRecord
  enum status: { passing: 1, failed: 2, passed: 3 }

  belongs_to :user
  belongs_to :test
  belongs_to :current_question, class_name: 'Question', optional: true, inverse_of: :test_passages

  scope :passing, -> { where(status: statuses[:passing]) }
  scope :failed, -> { where(status: statuses[:failed]) }
  scope :passed, -> { where(status: statuses[:passed]) }
  scope :tests_by_level, ->(level) { joins(:test).where(tests: { level: level }).pluck(:test_id) }

  before_create :set_passing_status
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

  def add_badges
    Badge.find_each do |badge|
      user.badges.push(badge) if badge.suitable?(self)
    end
  end

  private

  def correct_answer?(answer_id)
    Answer.find(answer_id).correct
  end

  def before_save_set_current_question
    return self.current_question = test.questions.order(:number).first if current_question.nil?
    self.current_question = test.questions.order(:number).find_by('number > ?', current_question.number)

    if completed?
      self.status = correct_answers_percent >= 85 ? TestPassage.statuses[:passed] : TestPassage.statuses[:failed]
    end
  end

  def set_passing_status
    self.status = TestPassage.statuses[:passing]
  end
end
