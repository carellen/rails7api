class User < ApplicationRecord
  has_many :lists, dependent: :restrict_with_error
  has_many :list_items, through: :lists

  has_secure_password

  validates :email, presence: true, uniqueness: { case_sensitive: false }
end
