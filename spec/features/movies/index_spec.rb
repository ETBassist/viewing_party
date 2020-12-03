require 'rails_helper'

describe 'Movies Page' do
  describe 'As a visitor' do
    before :each do
      visit '/movies'
    end

    it 'I see the 40 top rated movies', :vcr do
      expect(page).to have_selector('.movie', count: 40)
      expect(page).to have_button('Discover Top 40 Movies')
      expect(page).to have_field(:search)
      expect(page).to have_button('Search For Movies')
      within(first('.movie')) do
        expect(page).to have_css('.movie-title')
        expect(page).to have_css('.vote-average')
      end
    end

    it "I see a text field with a 'Find Movies' button", :vcr do
      within "#search-movies" do
        expect(page.has_field? :search).to be_truthy
        expect(page).to have_button "Search For Movies"
      end
    end

    it "I can search by movie title and see up top 40 results for that search", :vcr do
      fill_in :search, with: 'Love'
      click_on 'Search For Movies'
      expect(current_path).to eq('/movies')

      within '#results' do
        expect(page).to have_content("Love")
        expect(page).to have_content("Vote Average: ")
      end
    end

    it 'If no movie matches search result, user will recieve a message', :vcr do
      fill_in :search, with: 'The balloon popped and it was gibberish'
      click_on 'Search For Movies'
      expect(current_path).to eq('/movies')

      within '#results' do
        expect(page).to have_content("No movies have matched your request! Please try again!")
      end
    end
  end
end
