RSpec.describe Cart, type: :model do
  let(:user) { create(:user) }
  let(:cart) { create(:cart, user:) }
  let(:product1) { create(:product, price: 1000) }
  let(:product2) { create(:product, price: 2000) }

  describe '小計' do
    it '小計が計算される' do
      create(:cart_item, cart: cart, product: product1, quantity: 2)
      expect(cart.subtotal).to eq(2000)
    end

    it '小計が計算される(商品が複数)' do
      create(:cart_item, cart: cart, product: product1, quantity: 2)
      create(:cart_item, cart: cart, product: product2, quantity: 1)
      expect(cart.subtotal).to eq(4000)
    end
  end

  describe '送料' do
    it '送料が計算される(商品数が5)' do
      create(:cart_item, cart: cart, product: product1, quantity: 5)
      expect(cart.calculate_shipping_fee).to eq(600)
    end

    it '送料が計算される(商品数が6)' do
      create(:cart_item, cart: cart, product: product1, quantity: 6)
      expect(cart.calculate_shipping_fee).to eq(1200)
    end

    it '送料が計算される(商品数が10)' do
      create(:cart_item, cart: cart, product: product1, quantity: 10)
      expect(cart.calculate_shipping_fee).to eq(1200)
    end

    it '送料が計算される(商品数が11)' do
      create(:cart_item, cart: cart, product: product1, quantity: 11)
      expect(cart.calculate_shipping_fee).to eq(1800)
    end
  end

  describe '代引き手数料' do
    it '代引き手数料が計算される(小計が9,999円)' do
      product3 = create(:product, price: 999)
      create(:cart_item, cart: cart, product: product1, quantity: 9)
      create(:cart_item, cart: cart, product: product3, quantity: 1)
      expect(cart.cash_on_delivery_fee).to eq(300)
    end

    it '代引き手数料が計算される(小計が10,000円)' do
      create(:cart_item, cart: cart, product: product1, quantity: 10)
      expect(cart.cash_on_delivery_fee).to eq(400)
    end

    it '代引き手数料が計算される(小計が29,999円)' do
      product3 = create(:product, price: 999)
      create(:cart_item, cart: cart, product: product1, quantity: 29)
      create(:cart_item, cart: cart, product: product3, quantity: 1)
      expect(cart.cash_on_delivery_fee).to eq(400)
    end

    it '代引き手数料が計算される(小計が30,000円)' do
      create(:cart_item, cart: cart, product: product1, quantity: 30)
      expect(cart.cash_on_delivery_fee).to eq(600)
    end

    it '代引き手数料が計算される(小計が99,999円)' do
      product3 = create(:product, price: 999)
      create(:cart_item, cart: cart, product: product1, quantity: 99)
      create(:cart_item, cart: cart, product: product3, quantity: 1)
      expect(cart.cash_on_delivery_fee).to eq(600)
    end

    it '代引き手数料が計算される(小計が100,000円)' do
      create(:cart_item, cart: cart, product: product1, quantity: 100)
      expect(cart.cash_on_delivery_fee).to eq(1000)
    end
  end

  describe '合計金額' do
    it '小計、送料、代引き手数料、消費税の合計が計算される' do
      create(:cart_item, cart: cart, product: product1, quantity: 2)
      expected_total = (cart.total_exclude_tax * Cart::TAX_RATE).floor
      expect(cart.total_price).to eq(expected_total)
    end
  end

  describe '消費税' do
    it '消費税が計算される' do
      create(:cart_item, cart: cart, product: product1, quantity: 2)
      expected_tax = ((cart.total_exclude_tax * Cart::TAX_RATE).floor - cart.total_exclude_tax)
      expect(cart.tax_price).to eq(expected_tax)
    end
  end
end
