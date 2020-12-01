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

    it "I cannot create a new user with empty fields" do
      visit '/register'

      fill_in :name, with: "Brian"
      fill_in :password, with: "password"
      fill_in :password_confirmation, with: "pass"

      click_on "Register"

      expect(page).to have_content("Password confirmation doesn't match Password and Email can't be blank")
    end

    it "I cannot create a new user with pre-existing email" do
      User.create!(email: 'user@example.com', name: 'User2', password: '123')

      visit '/register'

      fill_in :email, with: "user@example.com"
      fill_in :name, with: "Brian"
      fill_in :password, with: "password"
      fill_in :password_confirmation, with: "password"

      click_on "Register"

      expect(page).to have_content("Email has already been taken")
    end
  end
end
