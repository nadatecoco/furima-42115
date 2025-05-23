class BuyersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_item, only: [:index, :create, :show]

  def index
    @buyer_address = BuyerAddress.new
  end

  def create
    @buyer_address = BuyerAddress.new(buyer_address_params)
    if @buyer_address.valid?
      pay_item
      @buyer_address.save
    else
      render :index, status: :unprocessable_entity
    end
  end

  def show
  end

  private

  def set_item
    @item = Item.find(params[:item_id])
  end

  def buyer_address_params
    params.permit(:postal_code, :prefecture_id, :city, :addresses, :building, :phone_number)
          .merge(user_id: current_user.id, item_id: params[:item_id], token: params[:token])
  end
end
