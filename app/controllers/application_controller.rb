class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  before_action :allow_iframe_requests

  private

  def allow_iframe_requests
    response.headers.delete('X-Frame-Options')
  end

  def logged_in?
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  helper_method :logged_in?
end
