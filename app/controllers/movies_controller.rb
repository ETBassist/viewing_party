class MoviesController < ApplicationController
  def index
    movie_container = []

    response = conn.get('/3/movie/top_rated?page=1')
    movie_container << get_json('/3/movie/top_rated?page=1')

    response = conn.get('/3/movie/top_rated?page=2')
    movie_container << get_json('/3/movie/top_rated?page=2')

    @movies = movie_container.flatten
  end

  private

  def conn
    conn = Faraday.new(url: 'https://api.themoviedb.org') do |faraday|
      faraday.params['api_key'] = ENV['MOVIE_DB_API_KEY']
    end
  end

  def get_json(url)
    response = conn.get(url)
    JSON.parse(response.body, symbolize_names: true)[:results]
  end
end
