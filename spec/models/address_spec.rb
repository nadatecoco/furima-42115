require 'rails_helper'

RSpec.describe Address, type: :model do
  describe 'アソシエーション' do
    it 'buyerと関連付けられている' do
      expect(Address.reflect_on_association(:buyer).macro).to eq :belongs_to
    end
  end

  describe 'バリデーション' do
    before do
      @address = build(:address)
    end

    it 'postal_codeが必須' do
      @address.postal_code = nil
      expect(@address).not_to be_valid
    end

    it 'prefecture_idが必須' do
      @address.prefecture_id = nil
      expect(@address).not_to be_valid
    end

    it 'cityが必須' do
      @address.city = nil
      expect(@address).not_to be_valid
    end

    it 'addressesが必須' do
      @address.addresses = nil
      expect(@address).not_to be_valid
    end

    it 'phone_numberが必須' do
      @address.phone_number = nil
      expect(@address).not_to be_valid
    end

    it 'buyer_idが必須' do
      @address.buyer = nil
      expect(@address).not_to be_valid
    end
  end
end
