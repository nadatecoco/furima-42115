class BuyersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_item, only: [:index, :create]

  def index
    @buyer_address = BuyerAddress.new
  end
end

def create
  binding.pry
end
