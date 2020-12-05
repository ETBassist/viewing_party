class Party < ApplicationRecord
  validates_presence_of :date, :party_duration, :time, :movie_title

  has_many :invitations
  has_many :users, through: :invitations
end
