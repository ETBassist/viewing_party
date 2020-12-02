require "rails_helper"

describe "Navigation Bar" do
  describe "As an authenticated user" do
    it "I can log out" do
      user = User.create!(email: 'user@example.com', name: 'User2', password: '123')

      visit "/"

      fill_in :email, with: user.email
      fill_in :password, with: user.password

      click_on "Login"

      click_on "Logout"

      expect(current_path).to eq("/")
      expect(page).to have_content("You have been logged out.")
    end
  end

  describe "As a visitor" do
    it "I do not see logout" do
      visit "/"
      expect(page).to_not have_content("Logout")
    end
  end
end
