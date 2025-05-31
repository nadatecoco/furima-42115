require 'rails_helper'

RSpec.describe BuyerAddress, type: :model do
  describe '配送先住所のバリデーション' do
    before do
      @buyer_address = build(:buyer_address)
    end

    context '正常系' do
      it '全ての値が正しく入力されていれば保存できる' do
        expect(@buyer_address).to be_valid
      end

      it '建物名は任意であること' do
        @buyer_address.building = ''
        expect(@buyer_address).to be_valid
      end
    end

    context '異常系' do
      it '郵便番号が必須であること' do
        @buyer_address.postal_code = ''
        @buyer_address.valid?
        expect(@buyer_address.errors.full_messages).to include("Postal code can't be blank")
      end

      it '郵便番号は「3桁ハイフン4桁」の半角文字列のみ保存可能なこと' do
        @buyer_address.postal_code = '1234567'
        @buyer_address.valid?
        expect(@buyer_address.errors.full_messages).to include('Postal code is invalid')
      end

      it '都道府県が必須であること' do
        @buyer_address.prefecture_id = 1
        @buyer_address.valid?
        expect(@buyer_address.errors.full_messages).to include('Prefecture must be other than 1')
      end

      it '市区町村が必須であること' do
        @buyer_address.city = ''
        @buyer_address.valid?
        expect(@buyer_address.errors.full_messages).to include("City can't be blank")
      end

      it '番地が必須であること' do
        @buyer_address.addresses = ''
        @buyer_address.valid?
        expect(@buyer_address.errors.full_messages).to include("Addresses can't be blank")
      end

      it '電話番号が必須であること' do
        @buyer_address.phone_number = ''
        @buyer_address.valid?
        expect(@buyer_address.errors.full_messages).to include("Phone number can't be blank")
      end

      it '電話番号は10桁以上11桁以内の半角数値のみ保存可能なこと - 9桁の場合' do
        @buyer_address.phone_number = '090123456'
        @buyer_address.valid?
        expect(@buyer_address.errors.full_messages).to include('Phone number is invalid')
      end

      it '電話番号は10桁以上11桁以内の半角数値のみ保存可能なこと - 12桁の場合' do
        @buyer_address.phone_number = '090123456789'
        @buyer_address.valid?
        expect(@buyer_address.errors.full_messages).to include('Phone number is invalid')
      end

      it '電話番号は10桁以上11桁以内の半角数値のみ保存可能なこと - ハイフンが含まれる場合' do
        @buyer_address.phone_number = '090-1234-5678'
        @buyer_address.valid?
        expect(@buyer_address.errors.full_messages).to include('Phone number is invalid')
      end

      it 'tokenが必須であること' do
        @buyer_address.token = ''
        @buyer_address.valid?
        expect(@buyer_address.errors.full_messages).to include("Token can't be blank")
      end

      it 'user_idが必須であること' do
        @buyer_address.user_id = ''
        @buyer_address.valid?
        expect(@buyer_address.errors.full_messages).to include("User can't be blank")
      end

      it 'item_idが必須であること' do
        @buyer_address.item_id = ''
        @buyer_address.valid?
        expect(@buyer_address.errors.full_messages).to include("Item can't be blank")
      end
    end
  end
end
