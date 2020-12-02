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

    it "I can log in" do
      user = User.create!(email: 'user@example.com', name: 'User2', password: '123')

      visit "/"

      fill_in :email, with: user.email
      fill_in :password, with: user.password

      click_on "Login"

      expect(current_path).to eq('/dashboard')
      expect(page).to have_content("Welcome, #{user.name}!")
    end

    it "I cannot log in with invalid credentials" do
      user = User.create!(email: 'user@example.com', name: 'User2', password: '123')

      visit "/"

      fill_in :email, with: user.email
      fill_in :password, with: 'pass'

      click_on "Login"

      expect(current_path).to eq('/')
      expect(page).to have_content("Your email or password was incorrect!")
    end
  end
end
