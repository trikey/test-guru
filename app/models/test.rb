class Test < ApplicationRecord
  belongs_to :category
  has_many :test_passages, dependent: :destroy
  has_many :users, through: :test_passages
  has_many :questions, dependent: :destroy
  belongs_to :author, class_name: 'User', foreign_key: :author_id, inverse_of: :authored_tests

  scope :easy,    -> { where(level: 0..1) }
  scope :medium,  -> { where(level: 2..4) }
  scope :hard,    -> { where(level: 5..Float::INFINITY) }
  scope :by_level, ->(level) { where(level: level) }

  scope :titles_by_category, lambda { |title|
    joins(:category).where(categories: { title: title }).order(title: :desc).pluck(:title)
  }

  validates :title, presence: true
  validates :level, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 1 }
end
