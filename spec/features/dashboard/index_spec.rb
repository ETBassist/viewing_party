require 'rails_helper'

describe 'Dashboard' do
  describe 'As a user' do
    before :each do
      @user = User.create(name: 'Brian', email: 'user@example.com', password: 'password')
      @user_2 = User.create(name: 'Bob Vance', email: 'user2@example.com', password: 'password')

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)
    end

    it 'I see a welcome message, a button to discover movies, a friends section, and a viewing parties section' do
      visit '/dashboard'

      expect(page).to have_content("Welcome, #{@user.name}!")
      expect(page).to have_link("Discover Movies")
      expect(page).to have_css(".friends")
      expect(page).to have_css(".viewing-parties")
    end

    it 'I can click a button to be taken to a discover page' do
      visit '/dashboard'

      click_link('Discover Movies')

      expect(current_path).to eq('/discover')
    end

    it "I can add and see my friends" do
      visit '/dashboard'

      expect(page).to have_content("You currently have no friends")

      within(".friends") do
        expect(page).to have_button("Add Friend")
        expect(page).to have_field(:friend_email)

        fill_in :friend_email, with: @user_2.email
        click_button "Add Friend"
      end

      expect(current_path).to eq("/dashboard")
      expect(page).to have_content("You have added #{@user_2.name} as a friend")

      within(".current_friends") do
        expect(page).to have_content(@user_2.name)
      end
    end

    it "I cant add a friend with an invalid email" do
      visit '/dashboard'

      within(".friends") do
        fill_in :friend_email, with: "garbage@example.com"
        click_button "Add Friend"
      end

      expect(page).to have_content("I'm sorry, your friend cannot be found :(")
    end
  end
end
