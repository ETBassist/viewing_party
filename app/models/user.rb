class User < ApplicationRecord
  has_secure_password

  validates :email, uniqueness: true, presence: true
  validates_presence_of :name

  has_many :friendships, dependent: :destroy
  has_many :friends, through: :friendships

  has_many :invitations
  has_many :parties, through: :invitations
end
