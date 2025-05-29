require 'rails_helper'

RSpec.describe BuyerAddress, type: :model do
  describe '配送先住所のバリデーション' do
    before do
      @user = create(:user)
      @item = build(:item)
      @item.save(validate: false)
    end

    context '正常系' do
      it '全ての値が正しく入力されていれば保存できる' do
        buyer_address = BuyerAddress.new(
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
        expect(buyer_address).to be_valid
      end

      it '建物名は任意であること' do
        buyer_address = BuyerAddress.new(
          postal_code: '123-4567',
          prefecture_id: 2,
          city: '横浜市',
          addresses: '1-1-1',
          building: '',
          phone_number: '09012345678',
          user_id: @user.id,
          item_id: @item.id,
          token: 'tok_abcdefghijk00000000000000000'
        )
        expect(buyer_address).to be_valid
      end
    end

    context '異常系' do
      it '郵便番号が必須であること' do
        buyer_address = BuyerAddress.new(
          postal_code: '',
          prefecture_id: 2,
          city: '横浜市',
          addresses: '1-1-1',
          phone_number: '09012345678',
          user_id: @user.id,
          item_id: @item.id,
          token: 'tok_abcdefghijk00000000000000000'
        )
        buyer_address.valid?
        expect(buyer_address.errors.full_messages).to include("Postal code can't be blank")
      end

      it '郵便番号は「3桁ハイフン4桁」の半角文字列のみ保存可能なこと' do
        buyer_address = BuyerAddress.new(
          postal_code: '1234567',
          prefecture_id: 2,
          city: '横浜市',
          addresses: '1-1-1',
          phone_number: '09012345678',
          user_id: @user.id,
          item_id: @item.id,
          token: 'tok_abcdefghijk00000000000000000'
        )
        buyer_address.valid?
        expect(buyer_address.errors.full_messages).to include('Postal code is invalid')
      end

      it '都道府県が必須であること' do
        buyer_address = BuyerAddress.new(
          postal_code: '123-4567',
          prefecture_id: 1,
          city: '横浜市',
          addresses: '1-1-1',
          phone_number: '09012345678',
          user_id: @user.id,
          item_id: @item.id,
          token: 'tok_abcdefghijk00000000000000000'
        )
        buyer_address.valid?
        expect(buyer_address.errors.full_messages).to include('Prefecture must be other than 1')
      end

      it '市区町村が必須であること' do
        buyer_address = BuyerAddress.new(
          postal_code: '123-4567',
          prefecture_id: 2,
          city: '',
          addresses: '1-1-1',
          phone_number: '09012345678',
          user_id: @user.id,
          item_id: @item.id,
          token: 'tok_abcdefghijk00000000000000000'
        )
        buyer_address.valid?
        expect(buyer_address.errors.full_messages).to include("City can't be blank")
      end

      it '番地が必須であること' do
        buyer_address = BuyerAddress.new(
          postal_code: '123-4567',
          prefecture_id: 2,
          city: '横浜市',
          addresses: '',
          phone_number: '09012345678',
          user_id: @user.id,
          item_id: @item.id,
          token: 'tok_abcdefghijk00000000000000000'
        )
        buyer_address.valid?
        expect(buyer_address.errors.full_messages).to include("Addresses can't be blank")
      end

      it '電話番号が必須であること' do
        buyer_address = BuyerAddress.new(
          postal_code: '123-4567',
          prefecture_id: 2,
          city: '横浜市',
          addresses: '1-1-1',
          phone_number: '',
          user_id: @user.id,
          item_id: @item.id,
          token: 'tok_abcdefghijk00000000000000000'
        )
        buyer_address.valid?
        expect(buyer_address.errors.full_messages).to include("Phone number can't be blank")
      end

      it '電話番号は10桁以上11桁以内の半角数値のみ保存可能なこと - 9桁の場合' do
        buyer_address = BuyerAddress.new(
          postal_code: '123-4567',
          prefecture_id: 2,
          city: '横浜市',
          addresses: '1-1-1',
          phone_number: '090123456',
          user_id: @user.id,
          item_id: @item.id,
          token: 'tok_abcdefghijk00000000000000000'
        )
        buyer_address.valid?
        expect(buyer_address.errors.full_messages).to include('Phone number is invalid')
      end

      it '電話番号は10桁以上11桁以内の半角数値のみ保存可能なこと - 12桁の場合' do
        buyer_address = BuyerAddress.new(
          postal_code: '123-4567',
          prefecture_id: 2,
          city: '横浜市',
          addresses: '1-1-1',
          phone_number: '090123456789',
          user_id: @user.id,
          item_id: @item.id,
          token: 'tok_abcdefghijk00000000000000000'
        )
        buyer_address.valid?
        expect(buyer_address.errors.full_messages).to include('Phone number is invalid')
      end

      it '電話番号は10桁以上11桁以内の半角数値のみ保存可能なこと - ハイフンが含まれる場合' do
        buyer_address = BuyerAddress.new(
          postal_code: '123-4567',
          prefecture_id: 2,
          city: '横浜市',
          addresses: '1-1-1',
          phone_number: '090-1234-5678',
          user_id: @user.id,
          item_id: @item.id,
          token: 'tok_abcdefghijk00000000000000000'
        )
        buyer_address.valid?
        expect(buyer_address.errors.full_messages).to include('Phone number is invalid')
      end
    end
  end
end
