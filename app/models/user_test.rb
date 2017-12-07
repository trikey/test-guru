class UserTest < ApplicationRecord
  PASSING = 1
  PASSED = 3
  PASSED_WITH_ERRORS = 2

  belongs_to :user
  belongs_to :test

  scope :passing, -> { where(status: PASSING) }
end
