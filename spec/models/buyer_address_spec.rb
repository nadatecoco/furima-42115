require 'rails_helper'

RSpec.describe BuyerAddress, type: :model do
  before do
    @user = FactoryBot.create(:user)
    @item = FactoryBot.create(:item)
    @buyer_address = BuyerAddress.new(
      postal_code: '123-4567',
      prefecture_id: 2,
      city: '横浜市',
      addresses: '1-1-1',
      building: 'テストビル',
      phone_number: '09012345678',
      user_id: @user.id,
      item_id: @item.id,
      token: 'tok_abcdefghijk00000000000000000'
    )
  end

  describe 'バリデーション' do
    context '正常系' do
      it '全ての値が正しく入力されていれば保存できる' do
        expect(@buyer_address).to be_valid
      end

      it 'buildingが空でも保存できる' do
        @buyer_address.building = ''
        expect(@buyer_address).to be_valid
      end
    end

    context '異常系' do
      it 'postal_codeが空だと保存できない' do
        @buyer_address.postal_code = ''
        expect(@buyer_address).not_to be_valid
      end

      it 'postal_codeが「3桁ハイフン4桁」でないと保存できない' do
        @buyer_address.postal_code = '1234567'
        expect(@buyer_address).not_to be_valid
      end

      it 'prefecture_idが1だと保存できない' do
        @buyer_address.prefecture_id = 1
        expect(@buyer_address).not_to be_valid
      end

      it 'cityが空だと保存できない' do
        @buyer_address.city = ''
        expect(@buyer_address).not_to be_valid
      end

      it 'addressesが空だと保存できない' do
        @buyer_address.addresses = ''
        expect(@buyer_address).not_to be_valid
      end

      it 'phone_numberが空だと保存できない' do
        @buyer_address.phone_number = ''
        expect(@buyer_address).not_to be_valid
      end

      it 'phone_numberが9桁以下だと保存できない' do
        @buyer_address.phone_number = '090123456'
        expect(@buyer_address).not_to be_valid
      end

      it 'phone_numberが12桁以上だと保存できない' do
        @buyer_address.phone_number = '090123456789'
        expect(@buyer_address).not_to be_valid
      end

      it 'phone_numberにハイフンが含まれていると保存できない' do
        @buyer_address.phone_number = '090-1234-5678'
        expect(@buyer_address).not_to be_valid
      end

      it 'tokenが空だと保存できない' do
        @buyer_address.token = ''
        expect(@buyer_address).not_to be_valid
      end

      it 'user_idが空だと保存できない' do
        @buyer_address.user_id = nil
        expect(@buyer_address).not_to be_valid
      end

      it 'item_idが空だと保存できない' do
        @buyer_address.item_id = nil
        expect(@buyer_address).not_to be_valid
      end
    end
  end

  describe '保存機能' do
    context '正常系' do
      it '正しい情報を入力すれば保存できる' do
        expect(@buyer_address.save).to be true
      end

      it '保存するとBuyerレコードが作成される' do
        expect do
          @buyer_address.save
        end.to change(Buyer, :count).by(1)
      end

      it '保存するとAddressレコードが作成される' do
        expect do
          @buyer_address.save
        end.to change(Address, :count).by(1)
      end

      it '保存したBuyerレコードの情報が正しい' do
        @buyer_address.save
        buyer = Buyer.last
        expect(buyer.user_id).to eq @user.id
        expect(buyer.item_id).to eq @item.id
      end

      it '保存したAddressレコードの情報が正しい' do
        @buyer_address.save
        address = Address.last
        expect(address.postal_code).to eq '123-4567'
        expect(address.prefecture_id).to eq 2
        expect(address.city).to eq '横浜市'
        expect(address.addresses).to eq '1-1-1'
        expect(address.building).to eq 'テストビル'
        expect(address.phone_number).to eq '09012345678'
      end
    end

    context '異常系' do
      it 'バリデーションに失敗した場合は保存できない' do
        @buyer_address.postal_code = ''
        expect(@buyer_address.save).to be false
      end

      it 'バリデーションに失敗した場合はBuyerレコードが作成されない' do
        @buyer_address.postal_code = ''
        expect do
          @buyer_address.save
        end.not_to change(Buyer, :count)
      end

      it 'バリデーションに失敗した場合はAddressレコードが作成されない' do
        @buyer_address.postal_code = ''
        expect do
          @buyer_address.save
        end.not_to change(Address, :count)
      end
    end
  end
end
