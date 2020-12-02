class MoviesController < ApplicationController
  def index
    movie_container = []
    conn = Faraday.new('https://api.themoviedb.org') do |faraday|
      faraday.params['api_key'] = ENV['MOVIE_DB_API_KEY']
    end
    response = conn.get('/3/movie/top_rated?page=1')
    movie_container << JSON.parse(response.body, symbolize_names: true)[:results]
    response = conn.get('/3/movie/top_rated?page=2')
    movie_container << JSON.parse(response.body, symbolize_names: true)[:results]
    @movies = movie_container.flatten
  end
end
