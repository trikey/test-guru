class Badge < ApplicationRecord
  RULES = [
      [ 'First successful test passage', 1],
      [ 'Finished all level 1 tests', 2],
      [ '3 failed tests', 3]
  ].freeze

  has_many :users, through: :user_badge
  validates :name,  presence: true
  validates :path,  presence: true

  self

  def rules
    RULES
  end

  def rule(id)
    rule = RULES.detect {|e| e[1] == id }
    rule[0] unless rule.nil?
  end

  def suitable?(test_passage)
    if self.rule_id == 1
      return test_passage.user.test_passages.passed.count == 1
    elsif self.rule_id == 2
      test_ids = test_passage.user.test_passages.passed.map do |passage|
        passage.test.level == 1 ? passage.test.id : nil
      end.uniq.compact.sort
      Test.where(level: 1).count == Test.where(id: test_ids).count
    elsif self.rule_id == 3 && test_passage.user.test_passages.failed.count > 0
      return test_passage.user.test_passages.failed.count % 3 == 0
    end
    false
  end
end
