class ListsController < ApplicationController

  before_filter :require_login
  before_filter :fetch_current_list, only: [:show, :destroy, :update]

  def create
    @list = List.new(params[:list])

    @list.users << current_user

    respond_to do |format|
      if @list.save
        format.json { render :show, status: :created, location: list_path(@list) }
      else
        format.json { render json: { errors: @list.errors }, status: :unprocessable_entity }
      end
    end
  end

  def index
    @lists = current_user.lists
  end

  def destroy
    @list.destroy

    respond_to do |format|
      format.json { head :no_content }
    end
  end

  def update
    respond_to do |format|
      if @list.update_attributes(params[:list])
        format.json { render :show, location: list_path(@list) }
      else
        format.json { render json: @list.errors, status: :unprocessable_entity }
      end
    end
  end
end
