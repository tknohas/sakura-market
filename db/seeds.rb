# Admin.create!(email: 'admin@example.com', password: 'password')
products = %w(にんじん 玉ねぎ ピーマン ジャガイモ 白菜 大根)
(1..products.length).each do |n|
  Product.create!(name: products[n - 1], price: n * 1000, description: "#{n}番目の商品です。", published_at: nil, position: n)
end
