require 'rails_helper'

RSpec.describe Buyer, type: :model do
  describe 'アソシエーション' do
    it 'userと関連付けられている' do
      expect(Buyer.reflect_on_association(:user).macro).to eq :belongs_to
    end

    it 'itemと関連付けられている' do
      expect(Buyer.reflect_on_association(:item).macro).to eq :belongs_to
    end

    it 'addressと関連付けられている' do
      expect(Buyer.reflect_on_association(:address).macro).to eq :has_one
    end
  end

  describe 'バリデーション' do
    it 'user_idが必須' do
      buyer = build(:buyer, user: nil)
      expect(buyer).not_to be_valid
    end

    it 'item_idが必須' do
      buyer = build(:buyer, item: nil)
      expect(buyer).not_to be_valid
    end
  end
end
