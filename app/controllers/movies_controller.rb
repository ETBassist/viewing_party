class MoviesController < ApplicationController
  def index
    movie_container = []

    if params[:search]
      response = get_json("/3/search/movie?query=#{params[:search]}")
      movie_container << response[:results]
      movie_container << get_json("/3/search/movie?query=#{params[:search]}&page=2") if response[:total_pages] > 1
    else
      movie_container << get_json('/3/movie/top_rated?page=1')[:results]
      movie_container << get_json('/3/movie/top_rated?page=2')[:results]
    end

    @movies = movie_container.flatten
  end

  def show
    movie_details = get_json("/3/movie/#{params[:id]}")
    movie_credits = get_json("/3/movie/#{params[:id]}/credits")
    movie_reviews = get_json("/3/movie/#{params[:id]}/reviews")

    @movie = Movie.new(movie_details, movie_credits, movie_reviews)
  end

  private

  def conn
    Faraday.new(url: 'https://api.themoviedb.org') do |faraday|
      faraday.params['api_key'] = ENV['MOVIE_DB_API_KEY']
    end
  end

  def get_json(url)
    response = conn.get(url)
    JSON.parse(response.body, symbolize_names: true)
  end
end
