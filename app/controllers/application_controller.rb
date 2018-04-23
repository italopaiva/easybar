class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  before_action :allow_iframe_requests

  rescue_from ActiveRecord::RecordNotFound, with: :not_found

  protected

  def set_user
    user_id = session[:user_id]
    @user ||= User.find(user_id)
  rescue ActiveRecord::RecordNotFound
    session[:user_id] = nil

    redirect_to root_url
  end

  def not_found
    flash[:warning] = 'Página não encontrada'

    redirect_to root_url
  end

  private

  def allow_iframe_requests
    response.headers.delete('X-Frame-Options')
  end

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def logged_in?
    current_user ? true : false
  end

  def is_admin?
    return false unless logged_in?

    @current_user.is_admin?
  end


  helper_method :current_user, :logged_in?, :is_admin?
end
