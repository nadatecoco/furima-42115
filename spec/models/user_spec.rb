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

  end
end