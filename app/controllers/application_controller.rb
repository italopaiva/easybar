class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  before_action :allow_iframe_requests

  rescue_from ActiveRecord::RecordNotFound, with: :not_found

  protected

  def not_found
    flash[:warning] = 'Página não encontrada'

    redirect_to root_url
  end

  private

  def allow_iframe_requests
    response.headers.delete('X-Frame-Options')
  end

  def logged_in?
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def is_admin?
    return false unless logged_in?

    @current_user.is_admin?
  end


  helper_method :logged_in?, :is_admin?
end
