class ItemsController < ApplicationController

  before_filter :require_login
  before_filter :fetch_current_list
  before_filter :fetch_current_item, only: [:show, :destroy, :update]

  def create
    @item = Item.new(params[:item])

    @item.list = @list

    respond_to do |format|
      if @item.save
        format.json { render :show, status: :created, location: list_items_path(@list) }
      else
        format.json { render json: { errors: @item.errors }, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @item.update_attributes(params[:item])
        format.json { render :show, location: list_item_path(@item) }
      else
        format.json { render json: @item.errors, status: :unprocessable_entity }
      end
    end
  end
 
  def destroy
    @item.destroy

    respond_to do |format|
      format.json { head :no_content }
    end
  end

  private
    def fetch_current_item
      @item ||= fetch_current_list.items.find(params[:id])
    end
end
