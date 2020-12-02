require 'rails_helper'

describe 'Movies Page' do
  describe 'As a visitor' do
    it 'I see the 40 top rated movies' do
      visit '/movies'

      expect(page).to have_selector('.movie', count: 40)
      expect(page).to have_button('Discover Top 40 Movies')
      expect(page).to have_field(:search)
      expect(page).to have_button('Search For Movies')
      within(first('.movie')) do
        expect(page).to have_css('.movie-title')
        expect(page).to have_css('.vote-average')
      end
    end
  end
end
