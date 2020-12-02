require 'rails_helper'

describe 'Dashboard' do
  describe 'As a user' do
    before :each do
      @user = User.create(name: 'Brian', email: 'user@example.com', password: 'password')

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)
    end

    it 'I see a welcome message, a button to discover movies, a friends section, and a viewing parties section' do
      visit '/dashboard'

      expect(page).to have_content("Welcome, #{@user.name}!")
      expect(page).to have_button("Discover Movies")
      expect(page).to have_css(".friends")
      expect(page).to have_css(".viewing-parties")
    end

    it 'I can click a button to be taken to a discover page' do
      visit '/dashboard'

      click_button('Discover Movies')

      expect(current_path).to eq('/discover')
    end
  end
end
