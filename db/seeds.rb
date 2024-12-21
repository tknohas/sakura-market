Admin.create!(email: 'admin@example.com', password: 'password')
User.create!(name: 'Alice', email: 'alice@example.com', password: 'password')

food_items = %w[
  アップル オレンジ バナナ ストロベリー グレープ
  メロン スイカ キウイ パイナップル マンゴー
  レモン ライム ブルーベリー ラズベリー ブラックベリー
  パパイヤ ドラゴンフルーツ パッションフルーツ チェリー ピーチ
  プラム プルーン アボカド グアバ ドリアン
  クランベリー フィグ ココナッツ デーツ リンゴ
]

(1..30).each do |n|
  Product.create!(name: food_items[n - 1], price: n * 1000, description: "#{n}番目の商品です。", published_at: Time.current, position: n)
end
