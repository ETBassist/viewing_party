class FriendshipsController < ApplicationController

  def create
    friend = User.find_by(email: params[:friend_email])
    user = User.find(current_user.id)
    
    if friend.nil?
      flash[:notice] = "I'm sorry, your friend cannot be found :("
    else
      user.friends << friend
      flash[:notice] = "You have added #{friend.name} as a friend"
    end

    redirect_to "/dashboard"
  end
end
