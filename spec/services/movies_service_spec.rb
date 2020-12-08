require 'rails_helper'

describe 'Movies Service', :vcr do
  it 'can return a movie' do
    response = MovieService.movie(550)

    expect(response).to be_a(Hash)

    expect(response).to have_key(:credits)
    expect(response[:credits]).to be_an(Hash)

    expect(response).to have_key(:reviews)
    expect(response[:reviews]).to be_an(Hash)

    expect(response).to have_key(:original_title)
    expect(response).to have_key(:id)
    expect(response).to have_key(:runtime)
    expect(response).to have_key(:vote_average)
  end

  it 'can return top rated movies' do
    response = MovieService.top_rated_movies

    expect(response).to be_an(Array)
    expect(response.size).to eq(40)
  end

  it 'can return movies by keyword' do
    response = MovieService.movies_by_keyword("Love")

    expect(response).to be_an(Array)
    expect(response.size).to eq(40)
  end
end
