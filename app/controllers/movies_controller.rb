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
end
