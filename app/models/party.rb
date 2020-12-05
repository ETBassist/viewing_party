class Party < ApplicationRecord
  validates_presence_of :date, :duration, :start_time, :movie_title

  has_many :invitations
  has_many :users, through: :invitations
end
