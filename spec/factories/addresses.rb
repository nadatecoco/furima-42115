FactoryBot.define do
  factory :address do
    postal_code { '123-4567' }
    prefecture_id { 2 }
    city { '横浜市' }
    addresses { '1-1-1' }
    building { 'テストビル' }
    phone_number { '09012345678' }
    association :buyer
  end
end
