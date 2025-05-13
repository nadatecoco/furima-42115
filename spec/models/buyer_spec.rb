require 'rails_helper'

RSpec.describe Buyer, type: :model do
  before do
    @buyer = FactoryBot.build(:buyer)
  end

  describe '購入情報の保存' do
    context '保存できる場合' do
      it 'itemとuserが紐付いていれば保存できる' do
        expect(@buyer).to be_valid
      end
    end

    context '保存できない場合' do
      it 'itemが紐付いていないと保存できない' do
        @buyer.item = nil
        @buyer.valid?
        expect(@buyer.errors.full_messages).to include('Item must exist')
      end

      it 'userが紐付いていないと保存できない' do
        @buyer.user = nil
        @buyer.valid?
        expect(@buyer.errors.full_messages).to include('User must exist')
      end
    end
  end
end
