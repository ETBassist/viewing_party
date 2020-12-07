require 'rails_helper'

describe 'Movies Show Page' do
  describe 'As a visitor' do
    before :each do
      visit '/movies'

      fill_in :search, with: 'Edge of Tomorrow'
      click_on 'Search For Movies'
      click_link 'Edge of Tomorrow'
    end

    it "I can see movie details", :vcr do

      expect(page).to have_css("#title")
      expect(page).to have_css('#vote_average')
      expect(page).to have_css('#runtime')
      expect(page).to have_css('.genres')
      expect(page).to have_css('.description')
      expect(page).to have_css('.cast_members')
      expect(page).to have_css('.reviews')
    end

    it "I do not see a link to create a viewing party", :vcr do
      expect(page).to have_no_link("Create Viewing Party")
    end
  end
end
