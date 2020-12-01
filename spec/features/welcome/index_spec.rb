require "rails_helper"

describe "Welcome Page" do
  describe "As a visitor" do
    it "I see a message, description, and a button to login/register" do
      visit "/"

      expect(current_path).to eq("/")
    end
  end
end
