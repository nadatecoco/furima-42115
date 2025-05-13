require 'rails_helper'

RSpec.describe Address, type: :model do
  before do
    @address = FactoryBot.build(:address)
  end

  describe '配送先情報の保存' do
    context '保存できる場合' do
      it 'postal_code, prefecture_id, city, house_number, phone_numberが存在すれば保存できる' do
        expect(@address).to be_valid
      end

      it 'building_nameは空でも保存できる' do
        @address.building_name = ''
        expect(@address).to be_valid
      end
    end

    context '保存できない場合' do
      it 'postal_codeが空では保存できない' do
        @address.postal_code = ''
        @address.valid?
        expect(@address.errors.full_messages).to include("Postal code can't be blank")
      end

      it 'postal_codeがハイフンを含むと保存できない' do
        @address.postal_code = '123-4567'
        @address.valid?
        expect(@address.errors.full_messages).to include('Postal code is invalid. Enter it as follows (e.g. 1234567)')
      end

      it 'postal_codeが7桁でないと保存できない' do
        @address.postal_code = '123456'
        @address.valid?
        expect(@address.errors.full_messages).to include('Postal code is invalid. Enter it as follows (e.g. 1234567)')
      end

      it 'prefecture_idが1では保存できない' do
        @address.prefecture_id = 1
        @address.valid?
        expect(@address.errors.full_messages).to include("Prefecture can't be blank")
      end

      it 'cityが空では保存できない' do
        @address.city = ''
        @address.valid?
        expect(@address.errors.full_messages).to include("City can't be blank")
      end

      it 'house_numberが空では保存できない' do
        @address.house_number = ''
        @address.valid?
        expect(@address.errors.full_messages).to include("House number can't be blank")
      end

      it 'phone_numberが空では保存できない' do
        @address.phone_number = ''
        @address.valid?
        expect(@address.errors.full_messages).to include("Phone number can't be blank")
      end

      it 'phone_numberがハイフンを含むと保存できない' do
        @address.phone_number = '090-1234-5678'
        @address.valid?
        expect(@address.errors.full_messages).to include('Phone number is invalid. Enter it as follows (e.g. 09012345678)')
      end

      it 'phone_numberが10桁未満では保存できない' do
        @address.phone_number = '090123456'
        @address.valid?
        expect(@address.errors.full_messages).to include('Phone number is invalid. Enter it as follows (e.g. 09012345678)')
      end

      it 'phone_numberが11桁を超えると保存できない' do
        @address.phone_number = '090123456789'
        @address.valid?
        expect(@address.errors.full_messages).to include('Phone number is invalid. Enter it as follows (e.g. 09012345678)')
      end

      it 'buyerが紐付いていないと保存できない' do
        @address.buyer = nil
        @address.valid?
        expect(@address.errors.full_messages).to include('Buyer must exist')
      end
    end
  end
end
