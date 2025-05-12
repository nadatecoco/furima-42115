FactoryBot.define do
  factory :item do
    title { Faker::Lorem.sentence }
    description { Faker::Lorem.paragraph }
    category_id { Faker::Number.between(from: 2, to: 11) }
    condition_id { Faker::Number.between(from: 2, to: 7) }
    fee_burden_id { Faker::Number.between(from: 2, to: 3) }
    origin_area_id { Faker::Number.between(from: 2, to: 48) }
    days_until_shipping_id { Faker::Number.between(from: 2, to: 4) }
    price { Faker::Number.between(from: 300, to: 9_999_999) }
    association :user

    after(:build) do |item|
      item.image.attach(
        io: File.open(Rails.root.join('spec/fixtures/files/test_image.png')),
        filename: 'test_image.png',
        content_type: 'image/png'
      )
    end
  end
end
