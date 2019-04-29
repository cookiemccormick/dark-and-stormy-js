class User < ApplicationRecord
  has_many :recipes, dependent: :destroy
  has_many :comments, dependent: :destroy

  validates :name, presence: true
  validates :email, presence: true, uniqueness: true
  validates :password, presence: true, unless: :uid?

  has_secure_password validations: false

  before_save :downcase_fields

  scope :alphabetical_name, -> { order("name asc") }

  def downcase_fields
    email.downcase!
  end
end