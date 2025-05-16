# spec/factories/users.rb
FactoryBot.define do
  factory :user do
    nickname            { 'testuser' }

    email               { Faker::Internet.unique.email }
    password            { 'abc123' }

    password_confirmation { password }
    last_name           { '山田' }
    first_name          { '太郎' }
    kana_last_name      { 'ヤマダ' }
    kana_first_name     { 'タロウ' }
    birthday            { '1990-01-01' }
  end

end

