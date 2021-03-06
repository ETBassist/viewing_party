require 'rails_helper'

RSpec.describe 'Delete Viewing Party' do
  describe "As an authenticated user hosting a party", :vcr do
    before :each do
      @user = User.create(name: 'Brian', email: 'user@example.com', password: 'password')
      @user_2 = User.create(name: 'Bob Vance', email: 'user2@example.com', password: 'password')
      @user_3 = User.create(name: 'Pam', email: 'user3@example.com', password: 'password')
      Friendship.create!(user_id: @user.id, friend_id: @user_2.id)
      Friendship.create!(user_id: @user.id, friend_id: @user_3.id)

      json_details_response = File.read('spec/fixtures/poros/movies/fight_club_details.json')

      details = JSON.parse(json_details_response, symbolize_names: true)

      @movie = Movie.new(details)

      time = DateTime.now.to_time.to_s
      date = DateTime.now.to_date.to_s

      @party = Party.create!(date: date,
                             party_duration: 150,
                             time: time,
                             movie_title: "#{@movie.title}",
                             host_id: @user.id,
                             movie_id: @movie.movie_id)

                Invitation.create!(party_id: @party.id,
                                   user_id: @user.id)

                Invitation.create!(party_id: @party.id,
                                   user_id: @user_2.id)

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)

      visit "/viewing_party/#{@party.id}"
    end

    it "I can delete a viewing party" do
      expect(page).to have_button("Delete Party")

      click_on "Delete Party"
      expect(current_path).to eq("/dashboard")
    end
  end

  it "Does not show delete button to anyone other than host" do
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user_2)
    expect(page).to_not have_button("Delete Party")
  end
end
