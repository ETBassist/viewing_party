require 'rails_helper'

describe Party, type: :model do
  describe 'validations' do
    it { should validate_presence_of :date }
    it { should validate_presence_of :duration }
    it { should validate_presence_of :start_time }
    it { should validate_presence_of :movie_title }
  end

  describe 'relationships' do
    it { should have_many :invitations }
    it { should have_many(:users).through(:invitations) }
  end
end
