class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  helper_method :current_user

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def require_user
    render file: 'public/404', status: :not_found unless current_user
  end

  def require_login
    flash[:notice] = 'Please log in or register to visit this page' unless current_user
    redirect_to '/' unless current_user
  end
end
