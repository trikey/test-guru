class User < ApplicationRecord
  has_many :user_tests, dependent: :destroy
  has_many :passing_tests, through: :user_tests, source: :tests
  has_many :tests, foreign_key: :author_id, dependent: :nullify

  scope :tests_by_level, lambda { |level|
    Test.joins(:user_tests).where(user_tests: { status: Test::PASSING }).where(level: level)
  }

  validates :first_name,            presence: true
  validates :email,                 presence: true
  validates :password,              presence: true
  validates :password_confirmation, presence: true
  validates :permission,            presence: true
end
