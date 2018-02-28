class Rule < ApplicationRecord
  has_many :badges, dependent: :nullify
  validates :name,      presence: true
  validates :rule_type, presence: true

  def passed?(test_passage)
    case rule_type
    when 'first_success'
      first_success?(test_passage)
    when 'by_level'
      passed_all_tests_by_level?(test_passage, rule_value)
    when 'by_failed'
      failed_tests?(test_passage, rule_value)
    else
      false
    end
  end

  def first_success?(test_passage)
    test_passage.user.test_passages.passed.count == 1
  end

  def passed_all_tests_by_level?(test_passage, level)
    passed_tests = test_passage.user.test_passages.passed.tests_by_level(level)
    unique_passed_tests_count = passed_tests.uniq.count
    Test.by_level(level).count == unique_passed_tests_count && passed_tests.count == unique_passed_tests_count
  end

  def failed_tests?(test_passage, fail_count)
    failed_attempts_count = test_passage.user.test_passages.failed.count
    (failed_attempts_count % fail_count).zero? && failed_attempts_count.positive?
  end
end
