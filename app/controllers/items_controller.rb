class ItemsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :edit, ]


  def index
  end

  def new
    @item = Item.new
  end

  def create
    @item = Item.create(item_params)
    @item.save
    if @item.save
      redirect_to root_path
    else
      render :new
    end
  end


  private
  def item_params
    params.require(:item).permit(:image, :title, :explanation, :category_id, :status_id, :delivery_charge_id, :shipping_area_id, :days_to_ship_id, :price).merge(user_id: current_user.id)
  end
end
