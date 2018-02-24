class TestPassage < ApplicationRecord
  enum status: { passing: 1, failed: 2, passed: 3 }

  belongs_to :user
  belongs_to :test
  belongs_to :current_question, class_name: 'Question', optional: true, inverse_of: :test_passages

  scope :passing, -> { where(status: statuses[:passing]) }
  scope :failed, -> { where(status: statuses[:failed]) }
  scope :passed, -> { where(status: statuses[:passed]) }

  before_create :set_passing_status
  before_save :before_save_set_current_question
  after_save :add_badges

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

  def add_badges
    if completed?
      Badge.all.each do |badge|
        if badge.suitable?(self)
          self.user.badges.push(badge)
        end
      end
    end
  end
end
