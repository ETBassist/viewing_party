class MoviesController < ApplicationController
  def index
    @movies = if params[:search].present?
                MoviesFacade.movies_by_keyword(params[:search])
              else
                MoviesFacade.top_rated_movies
              end
  end

  def show
    @movie = MoviesFacade.movie(params[:id])
    @top_ten_cast_members = MoviesFacade.cast_members_for(@movie)
    @reviews = MoviesFacade.reviews_for(@movie)
  end
end
