class User < ApplicationRecord
  has_many :user_tests, dependent: :destroy
  has_many :passing_tests, through: :user_tests, source: :tests
  has_many :tests, foreign_key: :author_id, dependent: :nullify

  def tests_by_difficulty_level(level)
    Test.joins(:user_tests).where(user_tests: { user_id: id, status: Test::PASSING }).where(level: level)
  end
end
