class Test < ApplicationRecord
  PASSING = 1
  PASSED = 3
  PASSED_WITH_ERRORS = 2

  belongs_to :category
  has_many :user_tests, dependent: :destroy
  has_many :users, through: :user_tests
  has_many :questions, dependent: :destroy
  belongs_to :author, class_name: 'User', foreign_key: :author_id

  scope :easy,    -> { where(level: 0..1) }
  scope :medium,  -> { where(level: 2..4) }
  scope :hard,    -> { where(level: 5..Float::INFINITY) }

  scope :titles_by_category, lambda { |title|
    joins(:category).where(categories: { title: title }).order(title: :desc).pluck('title')
  }

  validates :title, presence: true
  validates :level, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 1 }
  validates :name, uniqueness: { scope: :level }
end
