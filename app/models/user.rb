require 'digest/sha1'

class User < ApplicationRecord
  devise :database_authenticatable,
         :registerable,
         :recoverable,
         :rememberable,
         :trackable,
         :validatable,
         :confirmable

  enum permission: { admin: 1, editor: 2, user: 3 }

  has_many :authored_tests, class_name: 'Test', foreign_key: :author_id, dependent: :nullify, inverse_of: :author
  has_many :test_passages, dependent: :destroy
  has_many :tests, through: :test_passages
  has_many :gists, dependent: :nullify

  scope :tests_by_level, lambda { |level|
    Test.joins(:test_passages).where(test_passages: { status: TestPassage.status[:passing] }).where(level: level)
  }

  validates :last_name,   presence: true
  validates :first_name,  presence: true
  validates :email,       presence: true, format: /\w+@\w+\.{1}[a-zA-Z]{2,}/, uniqueness: true

  def test_passage(test)
    test_passages.order(id: :desc).find_by(test_id: test.id)
  end

  def admin?
    is_a?(Admin)
  end
end
