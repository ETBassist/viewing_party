require 'rails_helper'

describe Party, type: :model do
  describe 'validations' do
    it { should validate_presence_of :date }
    it { should validate_presence_of :party_duration }
    it { should validate_presence_of :time }
    it { should validate_presence_of :movie_title }
    it { should validate_presence_of :host_id }
  end

  describe 'relationships' do
    it { should have_many :invitations }
    it { should have_many(:users).through(:invitations) }
  end
end
