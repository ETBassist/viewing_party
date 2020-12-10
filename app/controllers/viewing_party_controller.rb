class ViewingPartyController < ApplicationController
  before_action :require_login, only: %i[show new edit]

  def show
    @party = Party.find(params[:id])
  end

  def new
    @movie = MoviesFacade.movie(params[:movie_id])
  end

  def create
    party = Party.new(party_params)
    if params[:friend] && party.save
      Invitation.create(party_id: party.id, user_id: current_user.id)
      params[:friend][:ids].each { |friend_id| create_and_send_invite_to(friend_id, party) }
      redirect_to '/dashboard'
    else
      flash[:notice] = party.errors.full_messages.to_sentence
      flash[:notice] = 'Add a friend first' if params[:friend].nil?
      redirect_to "/viewing_party/new/?movie_id=#{params[:movie_id]}"
    end
  end

  def edit
    @party = Party.find(params[:id])
    @invitees = current_user.friends.where.not(id: @party.users.pluck(:id))
  end

  def update
    @party = Party.find(params[:id])
    if @party.update(party_params)

      unless params[:friend].nil?
        params[:friend][:ids].each do |friend_id|
          Invitation.create(party_id: @party.id,
                            user_id: friend_id)
        end
      end
      redirect_to "/viewing_party/#{@party.id}"
    else
      flash[:notice] = @party.errors.full_messages.to_sentence
      render :edit
    end
  end

  def delete
    party = Party.find(params[:id])
    Invitation.where(party_id: party.id).destroy_all
    party.destroy
    redirect_to '/dashboard'
  end

  private

  def party_params
    params.permit(:date, :party_duration, :time, :movie_title, :host_id, :movie_id)
  end

  def create_and_send_invite_to(friend_id, party)
    friend = User.find(friend_id)
    email_info = { user: current_user,
                   friend: friend,
                   message: party.movie_title }
    Invitation.create(party_id: party.id,
                      user_id: friend_id)
    ViewingPartyMailer.inform(email_info, friend.email).deliver_now
  end
end
