class Question < ApplicationRecord
  belongs_to :test
  has_many :answers, dependent: :destroy
  has_many :test_passages, dependent: :nullify
  has_many :gists, dependent: :nullify

  validates :body, presence: true
  validates :number, presence: true
end
