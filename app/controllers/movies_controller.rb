class MoviesController < ApplicationController
  def index
    if params[:search] && !params[:search].empty?
      @movies = MoviesFacade.movies_by_keyword(params[:search])
    else
      @movies = MoviesFacade.top_rated_movies
    end
  end

  def show
    @movie = MoviesFacade.movie(params[:id])
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
