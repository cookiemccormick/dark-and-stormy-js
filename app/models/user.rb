class User < ApplicationRecord
  has_many :recipes, dependent: :destroy

  validates :name, presence: true
  validates :email, presence: true, uniqueness: true
  validates :birthday, presence: true
  validates :password, presence: true

  has_secure_password
end