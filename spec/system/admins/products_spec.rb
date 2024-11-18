RSpec.describe 'Products', type: :system do
  let!(:admin) { create(:admin) }
  let!(:product) { create(:product, name: 'にんじん', price: 1_000, description: '商品説明です。', position: 1) }

  before do
    admin_login(admin)
  end

  describe '商品登録' do
    context 'フォームの入力値が正常' do
      it '登録成功' do
        visit new_admins_product_path

        fill_in 'product_name', with: '豆腐'
        fill_in 'product_price', with: 1_000
        fill_in 'product_description', with: '甘いです。'
        attach_file 'product_image', file_fixture('test_image.jpg')
        fill_in 'product_position', with: 1
        click_button '登録する'

        expect(page).to have_content '登録しました'
        expect(page).to have_css 'h2', text: '商品一覧(管理画面)'
        expect(page).to have_content '豆腐'
        expect(page).to have_css 'img.attached-product-image'
        expect(Product.last.position).to eq 1
        expect(page).to have_content '1,000円'
      end
    end

    context 'フォームの入力値が異常' do
      it '登録失敗' do
        visit new_admins_product_path

        fill_in 'product_name', with: ''
        fill_in 'product_price', with: ''
        fill_in 'product_description', with: ''
        click_button '登録する'

        expect(page).to have_content '件のエラーが発生したため 商品 は保存されませんでした。'
        expect(page).to have_css 'h2', text: '商品登録'
      end
    end
  end

  describe '商品編集' do
    context 'フォームの入力値が正常' do
      it '編集成功' do
        visit edit_admins_product_path(product)

        fill_in 'product_name', with: 'ピーマン'
        fill_in 'product_price', with: 2_000
        fill_in 'product_description', with: '苦いです。'
        attach_file 'product_image', file_fixture('test_image.jpg')
        fill_in 'product_position', with: 2
        click_button '変更する'

        expect(page).to have_content '変更しました'
        expect(page).to have_css 'h2', text: '商品一覧(管理画面)'
        expect(page).to have_css 'img.attached-product-image'
        expect(page).to have_content 'ピーマン'
        expect(page).to have_content '2,000円'
        expect(Product.last.position).to eq 2
      end
    end

    context 'フォームの入力値が異常' do
      it '編集失敗' do
        visit edit_admins_product_path(product)

        fill_in 'product_name', with: ''
        fill_in 'product_price', with: ''
        fill_in 'product_description', with: ''
        click_button '変更する'

        expect(page).to have_content '件のエラーが発生したため 商品 は保存されませんでした。'
        expect(page).to have_css 'h2', text: '商品編集'
      end
    end

    it '商品を削除できる', :js do
      visit edit_admins_product_path(product)

      click_on '削除'
      expect do
        expect(page.accept_confirm).to eq '本当に削除しますか？'
        expect(page).to have_content '削除しました'
      end.to change(Product, :count).by(-1)
    end
  end

  describe '商品一覧' do
    it '商品情報が表示される' do
      visit admins_root_path

      expect(page).to have_css 'h2', text: '商品一覧'
      expect(page).to have_content 'にんじん'
      expect(page).to have_content '1,000円'
      expect(page).to have_css 'img.product-image'
    end

    it '商品編集画面へ遷移する' do
      visit admins_root_path
      click_on '編集'

      expect(page).to have_css 'h2', text: '商品編集'
    end

    it '商品登録画面へ遷移する' do
      click_on '商品登録画面'

      expect(page).to have_css 'h2', text: '商品登録'
    end
  end

  describe '商品の表示順' do
    let!(:product1) { create(:product, name: 'ピーマン', price: 2_000, position: 2) }
    let!(:product2) { create(:product, name: '玉ねぎ', price: 3_000, position: 3) }

    it '表示順を設定できる' do
      visit edit_admins_product_path(product1)

      fill_in 'product_position', with: 1
      click_on '変更する'

      expect(page).to have_css 'h2', text: '商品一覧(管理画面)'
      sorted_products = all('.card-body .card-title').map(&:text)
      expect(sorted_products).to eq %w[ピーマン にんじん 玉ねぎ]

      visit edit_admins_product_path(product2)

      fill_in 'product_position', with: 1
      click_on '変更する'

      expect(page).to have_css 'h2', text: '商品一覧(管理画面)'
      sorted_products = all('.card-body .card-title').map(&:text)
      expect(sorted_products).to eq %w[玉ねぎ ピーマン にんじん]
    end
  end

  describe 'ページネーション', type: :system do
    before do
      create_list(:product, 30)
    end

    it 'ページにつき２４件の商品が表示される' do
      visit admins_products_path

      expect(page).to have_selector('.card-title', count: 24)
    end

    it 'ページネーションのリンクが表示される' do
      visit admins_products_path

      within '.pagination' do
        expect(page).to have_link('次へ', href: '/admins?page=2')
        expect(page).not_to have_link('前へ')
      end
    end

    it '次のページが表示される' do
      visit admins_products_path
      click_on '次へ'

      expect(page).to have_selector('.card-title', count: 7)

      within '.pagination' do
        expect(page).to have_link('前へ', href: '/admins')
        expect(page).not_to have_link('次へ', href: '/admins?page=3')
      end
    end
  end

  describe '詳細画面' do
    it '商品情報が表示される' do
      click_on 'にんじん'

      expect(page).to have_css 'h1', text: '商品詳細(管理画面)'
      expect(page).to have_content 'にんじん'
      expect(page).to have_content '1,000円'
      expect(page).to have_content '商品説明です。'
      expect(page).to have_button '公開する'
    end
  end
end
