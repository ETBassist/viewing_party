class ViewingPartyController < ApplicationController
  def show
    @party = Party.find(params[:id])
  end

  def new
    @movie = quick_fix(params[:movie_id])
  end

  def create
    party = Party.new(party_params)

    if params[:friend] && party.save
      Invitation.create(party_id: party.id,
                        user_id: current_user.id)
      params[:friend][:ids].each do |friend_id|
        Invitation.create(party_id: party.id,
                          user_id: friend_id)
      end
      redirect_to '/dashboard'
    else
      flash[:notice] = party.errors.full_messages.to_sentence
      flash[:notice] = "Add a friend first" if params[:friend].nil?
      redirect_to "/viewing_party/new/?movie_id=#{params[:movie_id]}"
    end
  end

  private

  def party_params
    params.permit(:date, :party_duration, :time, :movie_title, :host_id)
  end

  def quick_fix(movie_id)
    movie_details = get_json("/3/movie/#{movie_id}")
    movie_credits = get_json("/3/movie/#{movie_id}/credits")
    movie_reviews = get_json("/3/movie/#{movie_id}/reviews")

    Movie.new(movie_details, movie_credits, movie_reviews)
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
