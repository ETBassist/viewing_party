class Party < ApplicationRecord
  validates_presence_of :date, :party_duration, :time, :movie_title, :host_id

  has_many :invitations
  has_many :users, through: :invitations
end
