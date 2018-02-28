class Badge < ApplicationRecord
  has_many :users, through: :user_badge
  belongs_to :rule
  validates :name,  presence: true
  validates :path,  presence: true

  def suitable?(test_passage)
    rule.passed?(test_passage)
  end
end
