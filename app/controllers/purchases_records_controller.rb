class PurchasesRecordsController < ApplicationController
  before_action :authenticate_user!, only: [:index]
  before_action :set_item, only: [:index, :create]
  before_action :sold_action, only: [:index]
  before_action :sold_self, only: [:index]
  

  def index
    @purchases_address = PurchasesAddress.new
  end

  def create
    @purchases_address = PurchasesAddress.new(purchases_address_params)
    if @purchases_address.valid?
      pay_item
      @purchases_address.save
      return redirect_to root_path
    else
      render :index
    end
  end



  private 

  def purchases_address_params
    params.require(:purchases_address).permit(:post_code, :shipping_area_id, :municipalities, :address, :building_name, :telephone_number).merge(user_id: current_user.id, item_id: params[:item_id], token: params[:token])
  end

  def set_item
    @item = Item.find(params[:item_id])
  end

  def pay_item
    Payjp.api_key = ENV["PAYJP_SECRET_KEY"]
    Payjp::Charge.create(
      amount: @item.price,
      card: purchases_address_params[:token],
      currency: 'jpy'
    )
  end

  def sold_action
    if @item.purchases_record.present?
      redirect_to root_path
    end
  end

  def sold_self
    if current_user.id == @item.user.id
      redirect_to root_path
    end
  end
end
