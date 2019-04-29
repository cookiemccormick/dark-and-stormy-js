class User < ApplicationRecord
  has_many :recipes, dependent: :destroy
  has_many :comments, dependent: :destroy

  validates :name, presence: true
  validates :email, presence: true, uniqueness: true
  validates :password, presence: true, unless: :uid?

  has_secure_password validations: false

  def no_recipes?
    self.recipes.count == 0
  end
end