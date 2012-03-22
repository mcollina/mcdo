class ApplicationController < ActionController::Base
  protect_from_forgery

  private
    def user_authenticated?
      not session[:user_id].nil?
    end

    def current_user
      @user ||= User.find(session[:user_id]) if user_authenticated?
    end

    def require_login
      return true if user_authenticated?

      respond_to do |format|
        format.json { render json: { status: "not authenticated" }, status: :forbidden }
      end

      return false # so we do no proceeed
    end

    def fetch_current_list
      @list ||= current_user.lists.find(params[:list_id] || params[:id])
    end
end
