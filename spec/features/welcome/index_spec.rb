require "rails_helper"

describe "Welcome Page" do
  describe "As a visitor" do
    it "I see a message, description, and a button to login/register" do
      visit "/"

      expect(current_path).to eq("/")

      expect(page).to have_content("Welcome to Viewing Party")
      expect(page).to have_content("Viewing party is an application in which users can explore movie options and create a viewing party event for the user and friends.")
      expect(page).to have_button("Login")
      expect(page).to have_link("New to Viewing Party? Register Here")
    end
  end
end
