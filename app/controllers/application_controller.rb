class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.

  helper_method :current_user
  before_filter :authenticate_user

  private

	def current_user
	  @current_user ||= User.find(session[:user_id]) if session[:user_id]
	end

	def authenticate_user
	  unless current_user
		  redirect_to new_session_url
	  end
	  return true
  end
end
