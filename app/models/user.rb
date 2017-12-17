class User < ApplicationRecord
  has_many :authored_tests, class_name: 'Test', foreign_key: :author_id, dependent: :nullify
  has_many :test_passages, dependent: :destroy
  has_many :tests, through: :test_passages

  scope :tests_by_level, lambda { |level|
    Test.joins(:test_passages).where(test_passages: { status: TestPassage::PASSING }).where(level: level)
  }

  validates :first_name,            presence: true
  validates :email,                 presence: true
  validates :password,              presence: true
  validates :password_confirmation, presence: true
  validates :permission,            presence: true

  def test_passage(test)
    test_passages.order(id: :desc).find_by(test_id: test.id)
  end
end
