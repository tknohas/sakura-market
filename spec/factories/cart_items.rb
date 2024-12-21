FactoryBot.define do
  factory :cart_item do
    cart { nil }
    product { nil }
    quantity { 0 }
  end
end
