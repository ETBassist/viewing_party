class SessionsController < ApplicationController
  def create
    user = User.find_by(email: params[:email])
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      flash[:notice] = "Welcome, #{user.name}!"
      redirect_to '/dashboard'
    else
      flash[:notice] = 'Your email or password was incorrect!'
      redirect_to '/'
    end
  end

  def destroy
    session.delete(:user_id)
    flash[:success] = 'You have been logged out.'
    redirect_to '/'
  end
end
