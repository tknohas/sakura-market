FactoryBot.define do
  factory :product do
    name { 'にんじん' }
    price { 1_000 }
    description { '商品説明です。' }
    published_at { nil }
    sequence(:position) { |n| n }
  end
end
