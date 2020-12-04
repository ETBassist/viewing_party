require "rails_helper"

describe User do
  describe "Validations" do
    it {should validate_presence_of :email}
    it {should validate_uniqueness_of :email}
    it {should validate_presence_of :name}
  end

  describe "Relationship" do
    it {should have_many(:friendships)}
    it {should have_many(:friends).through :friendships}
  end
end
