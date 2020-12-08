class Party < ApplicationRecord
  validates :date, :party_duration, :time, :movie_title, :host_id, presence: true

  has_many :invitations
  has_many :users, through: :invitations
end
