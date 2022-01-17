class PurchasesRecordsController < ApplicationController
  before_action :set_item, only: [:index, :create]


  def index
    @purchases_address = PurchasesAddress.new
  end

  def create
    @purchases_address = PurchasesAddress.new(purchases_address_params)
    if @purchases_address.valid?
      @purchases_address.save
      return redirect_to root_path
    else
      render :index
    end
  end



  private 

  def purchases_address_params
    params.require(:purchases_address).permit(:post_code, :shipping_area_id, :municipalities, :address, :building_name, :telephone_number).merge(user_id: current_user.id, item_id: params[:item_id])
  end

  def set_item
    @item = Item.find(params[:item_id])
  end
end
