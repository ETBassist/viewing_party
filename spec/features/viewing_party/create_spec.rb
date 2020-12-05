require "rails_helper"

describe 'Create Viewing Party' do
  describe 'As an authenticated user' do
    before :each do
      @user = User.create(name: 'Brian', email: 'user@example.com', password: 'password')
      @user_2 = User.create(name: 'Bob Vance', email: 'user2@example.com', password: 'password')

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)

      visit '/movies'

      fill_in :search, with: 'Edge of Tomorrow'
      click_on 'Search For Movies'
      click_link 'Edge of Tomorrow'
    end

    it "I see a link to create a viewing party and clicking this redirects me to a new viewing party form", :vcr do
      expect(page).to have_link("Create Viewing Party")

      within ".viewing-party" do
        click_on "Create Viewing Party"
      end

      within ".viewing-party-form" do
        expect(page).to have_content("Edge of Tomorrow")
        expect(find_field(:party_duration).value).to eq("113")
        page.find(:xpath, '//input[@id="date"]').set(DateTime.now.to_date.to_s)
        page.find(:xpath, '//input[@id="time"]').set(DateTime.now.to_time.to_s)
        # will need to add test/expectation to check friends can be added
        click_on "Create Party" 
      end
      expect(current_path).to eq("/viewing_party/new")
    end
  end

  describe "As a visitor" do
    it "I do not see a link to create a viewing party", :vcr do
      visit '/movies'

      fill_in :search, with: 'Edge of Tomorrow'
      click_on 'Search For Movies'
      click_link 'Edge of Tomorrow'

      within ".viewing-party" do
        expect(page).to have_no_link("Create Viewing Party")
      end
    end
  end
end
