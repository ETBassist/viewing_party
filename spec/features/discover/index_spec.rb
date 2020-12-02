require 'rails_helper'

describe 'Discover Index' do
  describe 'As a visitor' do
    it 'I see a button for top-40 movies' do
      visit '/discover'

      expect(page).to have_button('Discover Top 40 Movies')
      expect(page).to have_field(:search)
      expect(page).to have_button('Search For Movies')
    end
  end
end
