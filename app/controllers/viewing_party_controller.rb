class ViewingPartyController < ApplicationController
  def show
    @party = Party.find(params[:id])
  end

  def new
    @movie = MoviesFacade.movie(params[:movie_id])
  end

  def create
    party = Party.new(party_params)

    if params[:friend] && party.save
      Invitation.create(party_id: party.id,
                        user_id: current_user.id)
      params[:friend][:ids].each do |friend_id|
        friend = User.find(friend_id)
        Invitation.create(party_id: party.id,
                          user_id: friend_id)
      end
      redirect_to '/dashboard'
    else
      flash[:notice] = party.errors.full_messages.to_sentence
      flash[:notice] = 'Add a friend first' if params[:friend].nil?
      redirect_to "/viewing_party/new/?movie_id=#{params[:movie_id]}"
    end
  end

  private

  def party_params
    params.permit(:date, :party_duration, :time, :movie_title, :host_id)
  end
end
