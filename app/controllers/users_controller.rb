class UsersController < ApplicationController
  def new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      flash[:notice] = "Welcome, #{@user.name}!"
      redirect_to '/dashboard'
    else
      flash[:notice] = @user.errors.full_messages.to_sentence
      render :new
    end
  end

  private
    def user_params
      params.permit(:name, :email, :password, :password_confirmation)
    end
end
