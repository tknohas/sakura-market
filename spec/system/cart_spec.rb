RSpec.describe 'Carts', type: :system do
  let!(:product) { create(:product, name: 'にんじん', price: 1_000, description: '商品説明です。', position: 1, published_at: Time.current) }

  context 'ログインユーザーの場合' do
    let(:user) { create(:user) }
    let!(:cart) { create(:cart, user:) }

    before do
      user_login(user)
      expect(page).to have_content 'ログインしました'
    end

    it '商品をカートに追加できる' do
      visit product_path(product)

      expect do
        fill_in 'cart_item_quantity', with: 1
        click_on '登録する'

        expect(page).to have_content 'カートに追加しました'
      end.to change(CartItem, :count).by(1)
    end

    it 'カートの商品数を変更できる' do
      cart_item = create(:cart_item, product:, cart:, quantity: 1)

      click_on 'カート'

      fill_in 'cart_item_quantity', with: 2
      click_on '更新する'

      expect(page).to have_content '商品数を更新しました'
      cart_item.reload
      expect(cart_item.quantity).to eq 2
    end

    it 'カートの商品を削除できる', :js do
      create(:cart_item, product:, cart:, quantity: 1)

      click_on 'カート'

      expect do
        click_on '削除'

        expect(page.accept_confirm).to eq '本当に削除しますか？'
        expect(page).to have_content '削除しました'
      end.to change(CartItem, :count).by(-1)
    end
  end

  context 'セッションユーザーの場合' do
    let!(:cart) { create(:cart) }

    it '商品をカートに追加できる' do
      visit product_path(product)

      expect do
        fill_in 'cart_item_quantity', with: 1
        click_on '登録する'

        expect(page).to have_content 'カートに追加しました'
      end.to change(CartItem, :count).by(1)
    end

    it 'カートの商品数を変更できる' do
      visit product_path(product)

      fill_in 'cart_item_quantity', with: 1
      click_on '登録する'

      visit cart_path

      fill_in 'cart_item_quantity', with: 2
      click_on '更新する'

      expect(page).to have_content '商品数を更新しました'
      expect(CartItem.last.quantity).to eq 2
    end

    it 'カートの商品を削除できる', :js do
      visit product_path(product)

      fill_in 'cart_item_quantity', with: 1
      click_on '登録する'

      visit cart_path

      expect do
        click_on '削除'

        expect(page.accept_confirm).to eq '本当に削除しますか？'
        expect(page).to have_content '削除しました'
      end.to change(CartItem, :count).by(-1)
    end
  end
end
