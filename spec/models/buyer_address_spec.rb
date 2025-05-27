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
    end
  end

  describe '商品購入機能' do
    context '商品購入ができる場合' do
      it '全ての値が正しく入力されていれば購入できる' do
        expect(@buyer_address).to be_valid
      end
      it '建物名が空でも購入できる' do
        @buyer_address.building = ''
        expect(@buyer_address).to be_valid
      end
    end

    context '商品購入ができない場合' do
      it 'トークンが空では購入できない' do
        @buyer_address.token = ''
        @buyer_address.valid?
        expect(@buyer_address.errors.full_messages).to include('カード情報を入力してください')
      end
      it '郵便番号が空では購入できない' do
        @buyer_address.postal_code = ''
        @buyer_address.valid?
        expect(@buyer_address.errors.full_messages).to include('郵便番号を入力してください')
      end
      it '郵便番号が「3桁ハイフン4桁」の形式でないと購入できない' do
        @buyer_address.postal_code = '1234567'
        @buyer_address.valid?
        expect(@buyer_address.errors.full_messages).to include('郵便番号は不正な値です')
      end
      it '都道府県が未選択では購入できない' do
        @buyer_address.prefecture_id = 1
        @buyer_address.valid?
        expect(@buyer_address.errors.full_messages).to include('都道府県を選択してください')
      end
      it '市区町村が空では購入できない' do
        @buyer_address.city = ''
        @buyer_address.valid?
        expect(@buyer_address.errors.full_messages).to include('市区町村を入力してください')
      end
      it '番地が空では購入できない' do
        @buyer_address.addresses = ''
        @buyer_address.valid?
        expect(@buyer_address.errors.full_messages).to include('番地を入力してください')
      end
      it '電話番号が空では購入できない' do
        @buyer_address.phone_number = ''
        @buyer_address.valid?
        expect(@buyer_address.errors.full_messages).to include('電話番号を入力してください')
      end
      it '電話番号が10桁未満では購入できない' do
        @buyer_address.phone_number = '123456789'
        @buyer_address.valid?
        expect(@buyer_address.errors.full_messages).to include('電話番号は不正な値です')
      end
      it '電話番号が11桁を超えると購入できない' do
        @buyer_address.phone_number = '123456789012'
        @buyer_address.valid?
        expect(@buyer_address.errors.full_messages).to include('電話番号は不正な値です')
      end
      it '電話番号に半角数字以外が含まれていると購入できない' do
        @buyer_address.phone_number = '123-4567-8901'
        @buyer_address.valid?
        expect(@buyer_address.errors.full_messages).to include('電話番号は不正な値です')
      end
      it 'user_idが空では購入できない' do
        @buyer_address.user_id = ''
        @buyer_address.valid?
        expect(@buyer_address.errors.full_messages).to include('Userを入力してください')
      end
      it 'item_idが空では購入できない' do
        @buyer_address.item_id = ''
        @buyer_address.valid?
        expect(@buyer_address.errors.full_messages).to include('Itemを入力してください')
      end
    end
  end
end
