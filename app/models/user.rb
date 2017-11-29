class User < ApplicationRecord
  has_many :user_tests, dependent: :destroy
  has_many :tests, through: :user_tests

  def tests_by_difficulty_level(level)
    Test.joins(:user_tests).where(user_tests: { user_id: id, status: Test::PASSING }).where(level: level)
  end
end
