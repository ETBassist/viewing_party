class User < ApplicationRecord
  has_secure_password

  validates :email, uniqueness: true, presence: true
  validates :name, presence: true

  has_many :friendships, dependent: :destroy
  has_many :friends, through: :friendships

  has_many :invitations, dependent: :destroy
  has_many :parties, through: :invitations
end
