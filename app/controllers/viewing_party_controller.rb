class ViewingPartyController < ApplicationController
  def new
    @movie = quick_fix(params[:movie_id])
  end

  private
  def quick_fix(movie_id)
    movie_details = get_json("/3/movie/#{movie_id}")
    movie_credits = get_json("/3/movie/#{movie_id}/credits")
    movie_reviews = get_json("/3/movie/#{movie_id}/reviews")

    movie = Movie.new(movie_details, movie_credits, movie_reviews)
  end

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
