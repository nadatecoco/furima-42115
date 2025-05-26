require 'rails_helper'

RSpec.describe BuyersController, type: :controller do
  let(:user) { create(:user) }
  let(:item) { create(:item) }

  describe 'GET #index' do
    context 'ログインしている場合' do
      before do
        sign_in user
        get :index, params: { item_id: item.id }
      end

      it 'indexアクションにリクエストすると正常にレスポンスが返ってくる' do
        expect(response).to have_http_status(:ok)
      end

      it 'indexアクションにリクエストすると@itemが正しく設定される' do
        expect(assigns(:item)).to eq item
      end

      it 'indexアクションにリクエストすると@buyer_addressが正しく設定される' do
        expect(assigns(:buyer_address)).to be_a_new(BuyerAddress)
      end
    end

    context 'ログインしていない場合' do
      it 'ログインページにリダイレクトされる' do
        get :index, params: { item_id: item.id }
        expect(response).to redirect_to(new_user_session_path)
      end
    end
  end

  describe 'POST #create' do
    let(:valid_params) do
      {
        item_id: item.id,
        buyer_address: {
          postal_code: '123-4567',
          prefecture_id: 2,
          city: '横浜市',
          addresses: '1-1-1',
          building: 'テストビル',
          phone_number: '09012345678'
        },
        token: 'tok_abcdefghijk00000000000000000'
      }
    end

    context 'ログインしている場合' do
      before do
        sign_in user
      end

      context 'パラメータが正しい場合' do
        it '購入情報が保存される' do
          expect do
            post :create, params: valid_params
          end.to change(Buyer, :count).by(1)
        end

        it 'トップページにリダイレクトされる' do
          post :create, params: valid_params
          expect(response).to redirect_to(root_path)
        end

        it '支払い処理が実行される' do
          expect(Payjp::Charge).to receive(:create).with(
            amount: item.price,
            card: valid_params[:token],
            currency: 'jpy'
          )
          post :create, params: valid_params
        end
      end

      context 'パラメータが不正な場合' do
        it '購入情報が保存されない' do
          expect do
            post :create, params: { item_id: item.id, buyer_address: { postal_code: '' } }
          end.not_to change(Buyer, :count)
        end

        it 'indexアクションにレンダリングされる' do
          post :create, params: { item_id: item.id, buyer_address: { postal_code: '' } }
          expect(response).to render_template :index
        end

        it 'エラーメッセージが表示される' do
          post :create, params: { item_id: item.id, buyer_address: { postal_code: '' } }
          expect(assigns(:buyer_address).errors.full_messages).to include("Postal code can't be blank")
        end

        it '支払い処理が実行されない' do
          expect(Payjp::Charge).not_to receive(:create)
          post :create, params: { item_id: item.id, buyer_address: { postal_code: '' } }
        end
      end

      context '支払い処理が失敗した場合' do
        before do
          allow(Payjp::Charge).to receive(:create).and_raise(Payjp::CardError.new('カードエラー', 'card_error', 400))
        end

        it '購入情報が保存されない' do
          expect do
            post :create, params: valid_params
          end.not_to change(Buyer, :count)
        end

        it 'indexアクションにレンダリングされる' do
          post :create, params: valid_params
          expect(response).to render_template :index
        end

        it 'エラーメッセージが表示される' do
          post :create, params: valid_params
          expect(assigns(:buyer_address).errors.full_messages).to include('カード情報を正しく入力してください')
        end
      end
    end

    context 'ログインしていない場合' do
      it 'ログインページにリダイレクトされる' do
        post :create, params: valid_params
        expect(response).to redirect_to(new_user_session_path)
      end

      it '支払い処理が実行されない' do
        expect(Payjp::Charge).not_to receive(:create)
        post :create, params: valid_params
      end
    end
  end
end
