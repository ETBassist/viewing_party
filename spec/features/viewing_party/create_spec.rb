require "rails_helper"

describe 'Create Viewing Party', :vcr do
  describe 'As an authenticated user' do
    before :each do
      @user = User.create(name: 'Brian', email: 'user@example.com', password: 'password')
      @user_2 = User.create(name: 'Bob Vance', email: 'user2@example.com', password: 'password')
      Friendship.create!(user_id: @user.id, friend_id: @user_2.id)

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)

      visit '/movies'

      fill_in :search, with: 'Edge of Tomorrow'
      click_on 'Search For Movies'
      click_link 'Edge of Tomorrow'
    end

    it "I see a link to create a viewing party and clicking this redirects me to a new viewing party form", :vcr do
      time = DateTime.now.to_time.to_s
      date = DateTime.now.to_date.to_s

      expect(page).to have_link("Create Viewing Party")

      within ".viewing-party" do
        click_on "Create Viewing Party"
      end

      within ".viewing-party-form" do
        expect(page).to have_content("Edge of Tomorrow")
        expect(find_field(:party_duration).value).to eq("113")
        page.find(:xpath, '//input[@id="date"]').set(time)
        page.find(:xpath, '//input[@id="time"]').set(date)
        page.find("#friend_ids_#{@user_2.id}").set(true)

        click_on "Create Party"
      end
      expect(current_path).to eq("/dashboard")

      within('.viewing-parties') do
        expect(page).to have_content("Edge of Tomorrow")
        expect(page).to have_content(time)
        expect(page).to have_content(date)
        expect(page).to have_content("Hosting")
      end
    end

    it "I can add multiple friends to a party" do
      user_3 = User.create(name: 'Phyllis Smith', email: 'user3@example.com', password: 'password')
      Friendship.create!(user_id: @user.id, friend_id: user_3.id)

      time = DateTime.now.to_time.to_s
      date = DateTime.now.to_date.to_s

      within ".viewing-party" do
        click_on "Create Viewing Party"
      end

      within ".viewing-party-form" do
        expect(page).to have_content("Edge of Tomorrow")
        expect(find_field(:party_duration).value).to eq("113")
        page.find(:xpath, '//input[@id="date"]').set(time)
        page.find(:xpath, '//input[@id="time"]').set(date)

        page.find("#friend_ids_#{@user_2.id}").set(true)
        page.find("#friend_ids_#{user_3.id}").set(true)

        click_on "Create Party"
      end

      expect(current_path).to eq("/dashboard")

      within('.viewing-parties') do
        click_on("View Party")
      end

      # On party show page
      expect(page).to have_content(@user_2.name)
      expect(page).to have_content(user_3.name)
    end

    it "Other users can see their invited parties", :vcr do
      time = DateTime.now.to_time.to_s
      date = DateTime.now.to_date.to_s

      within ".viewing-party" do
        click_on "Create Viewing Party"
      end

      within ".viewing-party-form" do
        expect(page).to have_content("Edge of Tomorrow")
        expect(find_field(:party_duration).value).to eq("113")
        page.find(:xpath, '//input[@id="date"]').set(time)
        page.find(:xpath, '//input[@id="time"]').set(date)
        page.find("#friend_ids_#{@user_2.id}").set(true)

        click_on "Create Party"
      end

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user_2)

      visit '/dashboard'

      within('.viewing-parties') do
        expect(page).to have_content("Edge of Tomorrow")
        expect(page).to have_content(time)
        expect(page).to have_content(date)
        expect(page).to have_content("Invited")
      end
    end

    it "I cannot create a party with no friends" do
      time = DateTime.now.to_time.to_s
      date = DateTime.now.to_date.to_s

      within ".viewing-party" do
        click_on "Create Viewing Party"
      end

      within ".viewing-party-form" do
        expect(page).to have_content("Edge of Tomorrow")
        expect(find_field(:party_duration).value).to eq("113")
        page.find(:xpath, '//input[@id="date"]').set(time)
        page.find(:xpath, '//input[@id="time"]').set(date)

        click_on "Create Party"
      end

      expect(page).to have_content("Add a friend first")
    end

    it "I cannot create a viewing party with invalid fields" do
      within ".viewing-party" do
        click_on "Create Viewing Party"
      end

      within ".viewing-party-form" do
        expect(page).to have_content("Edge of Tomorrow")
        expect(find_field(:party_duration).value).to eq("113")
        page.find("#friend_ids_#{@user_2.id}").set(true)

        click_on "Create Party"
      end

      expect(page).to have_content("Date can't be blank and Time can't be blank")
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

    it "I cannot visit a viewing party page if I am not logged in" do
      user = User.create!(name: 'Key Lime Pie',
                          email: 'klp@example.com',
                          password: 'sosecure')
      party = Party.create!(movie_title: "Fight Club",
                           party_duration: 100,
                           time: '1200hrs',
                           date: 'tomorrow',
                           host_id: user.id,
                           movie_id: 550)
      visit viewing_party_path(party.id)
      expect(current_path).to eq(root_path)
    end
  end
end
