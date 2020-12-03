require 'rails_helper'

describe 'Movies Show Page' do
  describe 'As a visitor' do
    it "I can see movie details", :vcr do

      visit '/movies'

      fill_in :search, with: 'Edge of Tomorrow'
      click_on 'Search For Movies'
      click_link 'Edge of Tomorrow'

      expect(page).to have_css("#title")
      expect(page).to have_css('#vote_average')
      expect(page).to have_css('#runtime')
      expect(page).to have_css('.genres')
      expect(page).to have_css('.description')
      expect(page).to have_css('.cast_members')
      expect(page).to have_css('.reviews')
    end
  end
end
