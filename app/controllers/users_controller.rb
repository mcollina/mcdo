class UsersController < ApplicationController

  def create
    @user = User.new(params[:user])

    respond_to do |format|
      if @user.save

        # we store the @user.id in the session,
        # so we can fetch it in a later call
        session[:user_id] = @user.id

        format.json { render json: @user, status: :created, location: @user }
      else
        format.json { render json: { errors: @user.errors }, status: :unprocessable_entity }
      end
    end
  end

  def show
  end
end
