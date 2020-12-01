require "rails_helper"

describe "User New Page/Registration" do
  describe "As a visitor" do
    it "I create a new user" do
      visit '/register'

      fill_in :email, with: "user@example.com"
      fill_in :name, with: "Brian"
      fill_in :password, with: "password"
      fill_in :password_confirmation, with: "password"

      click_on "Register"

      expect(current_path).to eq("/dashboard")

      expect(page).to have_content("Welcome, Brian!")
    end
  end
end
