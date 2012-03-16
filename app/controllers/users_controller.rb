class UsersController < ApplicationController

  def create
    @user = User.new(params[:user])

    respond_to do |format|
      if @user.save
        format.json { render json: @user, status: :created, location: @user }
      else
        format.json { render json: { errors: @user.errors }, status: :unprocessable_entity }
      end
    end
  end

  def show
  end
end
