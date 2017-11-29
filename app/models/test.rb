class Test < ApplicationRecord
  PASSING = 1
  PASSED = 3
  PASSED_WITH_ERRORS = 2

  belongs_to :category
  has_many :user_tests, dependent: :destroy
  has_many :users, through: :user_tests

  def self.titles_by_category_name(title)
    joins(:category).where(categories: { title: title }).order(title: :desc).pluck('title')
  end
end
