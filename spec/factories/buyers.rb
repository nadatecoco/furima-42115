FactoryBot.define do
  factory :buyer do
    association :user
    association :item
  end
end
