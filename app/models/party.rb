class Party < ApplicationRecord
  validates_presence_of :date, :duration, :start_time, :movie_title
end
