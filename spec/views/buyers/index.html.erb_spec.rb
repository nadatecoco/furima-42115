require 'rails_helper'

RSpec.describe 'buyers/index', type: :view do
  let(:user) { create(:user) }
  let(:item) { create(:item) }
  let(:buyer_address) { BuyerAddress.new }

  before do
    sign_in user
    assign(:item, item)
    assign(:buyer_address, buyer_address)
    render
  end

  describe 'フォームの表示' do
    it '商品情報が表示されている' do
      expect(rendered).to have_content(item.name)
      expect(rendered).to have_content(item.price)
    end

    it '必須項目の入力フィールドが表示されている' do
      expect(rendered).to have_field('postal_code')
      expect(rendered).to have_field('prefecture_id')
      expect(rendered).to have_field('city')
      expect(rendered).to have_field('addresses')
      expect(rendered).to have_field('phone_number')
    end

    it '任意項目の入力フィールドが表示されている' do
      expect(rendered).to have_field('building')
    end

    it 'カード情報入力フォームが表示されている' do
      expect(rendered).to have_selector('#card-element')
    end

    it '購入ボタンが表示されている' do
      expect(rendered).to have_button('購入')
    end
  end

  describe 'エラー表示' do
    let(:buyer_address) do
      BuyerAddress.new(
        postal_code: '',
        prefecture_id: 1,
        city: '',
        addresses: '',
        phone_number: ''
      ).tap(&:valid?)
    end

    it 'エラーメッセージが表示される' do
      expect(rendered).to have_content('郵便番号を入力してください')
      expect(rendered).to have_content('都道府県を選択してください')
      expect(rendered).to have_content('市区町村を入力してください')
      expect(rendered).to have_content('番地を入力してください')
      expect(rendered).to have_content('電話番号を入力してください')
    end

    it 'エラー時の入力値が保持されている' do
      expect(rendered).to have_field('postal_code', with: '')
      expect(rendered).to have_field('prefecture_id', with: '1')
      expect(rendered).to have_field('city', with: '')
      expect(rendered).to have_field('addresses', with: '')
      expect(rendered).to have_field('phone_number', with: '')
    end
  end

  describe 'フォームの属性' do
    it 'フォームが正しいアクションを指している' do
      expect(rendered).to have_selector("form[action='#{item_buyers_path(item)}']")
    end

    it 'フォームが正しいメソッドを使用している' do
      expect(rendered).to have_selector("form[method='post']")
    end

    it 'フォームに必要な属性が含まれている' do
      expect(rendered).to have_selector("form[data-turbo='false']")
    end
  end
end
