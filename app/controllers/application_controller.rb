class ApplicationController < ActionController::Base
  protect_from_forgery

  private
    def user_authenticated?
      not session[:user_id].nil?
    end
end
