RSpec.describe 'Products', type: :system do
  let!(:published_product) { create(:product, name: 'にんじん', price: 1_000, description: '商品説明です。', position: 1, published_at: Time.current) }
  let!(:unpublished_product) { create(:product, name: 'ピーマン', price: 2_000, description: '商品説明です。', position: 2, published_at: nil) }

  describe '商品一覧' do
    it '公開設定されている商品情報が表示される' do
      visit products_path

      expect(page).to have_css 'h2', text: '商品一覧'
      expect(page).to have_content 'にんじん'
      expect(page).to have_content '1,000円'
      expect(page).to have_css 'img.product-image'
      expect(page).to_not have_content 'ピーマン'
      expect(page).to_not have_content '2,000円'
    end
  end

  describe '商品詳細' do
    it '商品情報が表示される' do
      visit product_path(published_product)

      expect(page).to have_css 'h2', text: '商品詳細'
      expect(page).to have_content 'にんじん'
      expect(page).to have_content '1,000円'
      expect(page).to have_css 'img.product-image'
      expect(page).to have_button '登録する'
    end
  end
end
