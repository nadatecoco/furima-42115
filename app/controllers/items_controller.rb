class ItemsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]

  def index
  end

  def new
    @item = Item.new
  end

  def create
    @item = Item.new(item_params)
    if @item.save
      redirect_to root_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def item_params
    params.require(:item).permit(:title, :description, :category_id, :condition_id, :fee_burden_id, :origin_area_id,
                                 :days_until_shipping_id, :price, :image).merge(user_id: current_user.id)
  end
end
