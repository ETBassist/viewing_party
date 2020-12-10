require 'rails_helper'

describe 'Viewing Part Show Page' do
  describe 'As an authenticated user' do
    before :each do
      @user = User.create(name: 'Brian', email: 'user@example.com', password: 'password')
      @user_2 = User.create(name: 'Bob Vance', email: 'user2@example.com', password: 'password')
      @user_3 = User.create(name: 'Pam', email: 'user3@example.com', password: 'password')
      Friendship.create!(user_id: @user.id, friend_id: @user_2.id)


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

    it "I can see viewing party details", :vcr do
      expect(page).to have_content("#{@party.movie_title}")
      expect(page).to have_content("#{@party.date}")
      expect(page).to have_content("#{@party.time}")
      expect(page).to have_content("#{@user_2.name}")
    end

    it 'I can click a link to see details about the party movie' do
      click_link('View Movie Details')

      expect(current_path).to eq("/movies/#{@movie.movie_id}")
    end
  end
end
