class Contact
  include ActiveModel::Validations
  attr_accessor :name, :email, :text

  def initialize(contact)
    @name = contact[:name]
    @email = contact[:email]
    @text = contact[:text]
  end

  validates :name, presence: true
  validates :email, presence: true, format: /\w+@\w+\.{1}[a-zA-Z]{2,}/
  validates :text, presence: true
end
