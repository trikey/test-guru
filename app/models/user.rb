require 'digest/sha1'

class User < ApplicationRecord
  enum permission: { admin: 1, editor: 2, user: 3 }

  has_many :authored_tests, class_name: 'Test', foreign_key: :author_id, dependent: :nullify
  has_many :test_passages, dependent: :destroy
  has_many :tests, through: :test_passages

  scope :tests_by_level, lambda { |level|
    Test.joins(:test_passages).where(test_passages: { status: TestPassage.status[:passing] }).where(level: level)
  }

  validates :first_name,  presence: true
  validates :email,       presence: true, format: /\w+@\w+\.{1}[a-zA-Z]{2,}/, uniqueness: true

  has_secure_password

  def test_passage(test)
    test_passages.order(id: :desc).find_by(test_id: test.id)
  end
end
