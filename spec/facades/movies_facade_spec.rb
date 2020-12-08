require 'rails_helper'

describe 'Movies Facade', :vcr do
  it 'returns a movie' do
    movie = MoviesFacade.movie(550)

    expect(movie).to be_a(Movie)
  end

  it 'returns top rated movies' do
    movies = MoviesFacade.top_rated_movies

    expect(movies).to be_an(Array)
    expect(movies.size).to eq(40)
    expect(movies.first).to be_an_instance_of(Movie)
  end

  it 'returns movies by keyword' do
    movies = MoviesFacade.movies_by_keyword("Love")

    expect(movies).to be_an(Array)
    expect(movies.size).to eq(40)
    expect(movies.first).to be_an_instance_of(Movie)
  end
end
