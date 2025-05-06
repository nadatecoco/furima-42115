require 'rails_helper'

RSpec.describe User, type: :model do
  before { @user = FactoryBot.build(:user) }

  context '新規登録可能' do
    it '全てあればれば登録できる' do
      expect(@user).to be_valid
    end
  end

  context '新規登録不可' do

    it 'email がない' do
      @user.email = ''
      @user.valid?
      expect(@user.errors.full_messages).to include "Email can't be blank"
    end

    it '重複した email がない' do
      @user.save
      another_user = FactoryBot.build(:user, email: @user.email)
      another_user.valid?
      expect(another_user.errors.full_messages).to include 'Email has already been taken'
    end

    it 'email に@がない' do
      @user.email = 'testexample.com'
      @user.valid?
      expect(@user.errors.full_messages).to include 'Email is invalid'
    end

    it 'password がない' do
      @user.password = ''
      @user.valid?
      expect(@user.errors.full_messages).to include "Password can't be blank"
    end

    it 'password が5文字以下で不可' do
      @user.password = @user.password_confirmation = 'a1b2c'
      @user.valid?
      expect(@user.errors.full_messages).to include 'Password is too short (minimum is 6 characters)'
    end

    it 'password と確認内容が一致' do
      @user.password_confirmation = 'different'
      @user.valid?
      expect(@user.errors.full_messages).to include "Password confirmation doesn't match Password"
    end

    it 'nickname がない' do
      @user.nickname = ''
      @user.valid?
      expect(@user.errors.full_messages).to include "Nickname can't be blank"
    end

    it 'last_name がない' do
      @user.last_name = ''
      @user.valid?
      expect(@user.errors.full_messages).to include "Last name can't be blank"
    end

    it 'last_name が半角' do
      @user.last_name = 'yamada'
      @user.valid?
      expect(@user.errors.full_messages).to include 'Last name is invalid'
    end

    it 'first_name がない' do
      @user.first_name = ''
      @user.valid?
      expect(@user.errors.full_messages).to include "First name can't be blank"
    end

    it 'first_name が半角' do
      @user.first_name = 'tarou'
      @user.valid?
      expect(@user.errors.full_messages).to include 'First name is invalid'
    end

    it 'kana_last_name がない' do
      @user.kana_last_name = ''
      @user.valid?
      expect(@user.errors.full_messages).to include "Kana last name can't be blank"
    end

    it 'kana_last_name がカタカナ以外' do
      @user.kana_last_name = 'やまだ'
      @user.valid?
      expect(@user.errors.full_messages).to include 'Kana last name is invalid'
    end

    it 'kana_first_name がない' do
      @user.kana_first_name = ''
      @user.valid?
      expect(@user.errors.full_messages).to include "Kana first name can't be blank"
    end

    it 'kana_first_name がカタカナ以外' do
      @user.kana_first_name = 'たろう'
      @user.valid?
      expect(@user.errors.full_messages).to include 'Kana first name is invalid'
    end

    it 'birthday がない' do
      @user.birthday = ''
      @user.valid?
      expect(@user.errors.full_messages).to include "Birthday can't be blank"
    end
      it 'passwordが英字のみ' do
        @user.password = @user.password_confirmation = 'abcdef'
        @user.valid?
        expect(@user.errors.full_messages)
          .to include('Password is invalid. Include both letters and numbers')
      end
  
      it 'passwordが数字のみ' do
        @user.password = @user.password_confirmation = '123456'
        @user.valid?
        expect(@user.errors.full_messages)
          .to include('Password is invalid. Include both letters and numbers')
      end
  
      it 'passwordに全角がある' do
        @user.password = @user.password_confirmation = 'abc123'
        @user.valid?
        expect(@user.errors.full_messages)
          .to include('Password is invalid. Include both letters and numbers')
      end

  end
end