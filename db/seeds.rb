Admin.create!(email: 'admin@example.com', password: 'password')
User.create!(name: 'Alice', email: 'alice@example.com', password: 'password')
(1..30).each do |n|
  Product.create!(name: n, price: n * 1000, description: "#{n}番目の商品です。", published_at: Time.current, position: n)
end
