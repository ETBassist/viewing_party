require 'rails_helper'

RSpec.describe 'Edit Viewing Party' do
  describe "As an authenticated user hosting a party", :vcr do
    before :each do
      @user = User.create(name: 'Brian', email: 'user@example.com', password: 'password')
      @user_2 = User.create(name: 'Bob Vance', email: 'user2@example.com', password: 'password')
      @user_3 = User.create(name: 'Pam', email: 'user3@example.com', password: 'password')
      Friendship.create!(user_id: @user.id, friend_id: @user_2.id)
      Friendship.create!(user_id: @user.id, friend_id: @user_3.id)

      json_details_response = File.read('spec/fixtures/poros/movies/fight_club_details.json')

      details = JSON.parse(json_details_response, symbolize_names: true)

      movie = Movie.new(details)

      time = DateTime.now.to_time.to_s
      date = DateTime.now.to_date.to_s

      @party = Party.create!(date: date, party_duration: 150, time: time, movie_title: "#{movie.title}", host_id: @user.id)

                Invitation.create!(party_id: @party.id,
                                   user_id: @user.id)

                Invitation.create!(party_id: @party.id,
                                   user_id: @user_2.id)

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)

      visit "/viewing_party/#{@party.id}"
    end

    it "I can edit the details of my viewing party" do
      time = DateTime.now.to_time.to_s
      date = DateTime.now.to_date.to_s

      expect(page).to have_button("Edit Party")

      click_on "Edit Party"
      expect(current_path).to eq("/viewing_party/#{@party.id}/edit")

      within ".viewing-party-edit-form" do
        page.find(:xpath, '//input[@id="date"]').set(time)
        page.find(:xpath, '//input[@id="time"]').set(date)
        page.find("#friend_ids_#{@user_3.id}").set(true)

        click_on "Update Party"
      end

      expect(current_path).to eq("/viewing_party/#{@party.id}")
      expect(page).to have_content(time)
      expect(page).to have_content(date)
    end

    it 'I cannot update the party if I delete the time' do
      time = DateTime.now.to_time.to_s

      expect(page).to have_button("Edit Party")

      click_on "Edit Party"
      expect(current_path).to eq("/viewing_party/#{@party.id}/edit")

      within ".viewing-party-edit-form" do
        page.find(:xpath, '//input[@id="date"]').set(time)
        page.find(:xpath, '//input[@id="time"]').set('')
        page.find("#friend_ids_#{@user_3.id}").set(true)

        click_on "Update Party"
      end

      expect(page).to have_content("Time can't be blank")
    end
  end

  it "Does not show edit button to anyone other than host" do
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user_2)
    expect(page).to_not have_button("Edit Party")
  end
end
