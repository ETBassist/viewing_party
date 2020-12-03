require 'rails_helper'

describe 'Movies Show Page' do
  describe 'As a visitor' do
    it "I can see movie details", :vcr do

      visit '/movies'

      fill_in :search, with: 'Edge of Tomorrow'
      click_on 'Search For Movies'
      click_link 'Edge of Tomorrow'

      save_and_open_page
      # expect(page).to have_content(movie.title)
      # expect(page).to have_content(movie.vote_average)
      # expect(page).to have_content(movie.runtime)
      # expect(page).to have_content(movies.genre)
      # expect(page).to have_content(movies.description)
      # expect(page).to have_content(movie.cast_members)
    end
  end
end
