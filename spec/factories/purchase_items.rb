FactoryBot.define do
  factory :purchase_item do
    product { nil }
    purchase { nil }
    quantity { 0 }
    name { "MyString" }
    price { 0 }
  end
end
