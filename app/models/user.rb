class User < ApplicationRecord
  has_many :recipes, dependent: :destroy
  has_many :comments, dependent: :destroy

  validates :name, presence: true
  validates :email, presence: true, uniqueness: true
  validates :password, presence: true, unless: :uid?

  #disabled validations for has_secure_password, because of the custom validation above that allows for users to signin through FB
  has_secure_password validations: false

  #Callbacks - hooks into the life cycle of an active record object that allow you to trigger logic before and after changing the object state
  before_save :downcase_fields

  scope :alphabetical_name, -> { order("name asc") }

  def downcase_fields
    email.downcase!
  end
end