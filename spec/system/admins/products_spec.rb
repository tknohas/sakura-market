RSpec.describe 'Products', type: :system do
  let!(:admin) { create(:admin) }

  before do
    admin_login(admin)
  end

  describe '商品登録' do
    context 'フォームの入力値が正常' do
      it '登録成功' do
        visit new_admins_product_path

        fill_in 'product_name', with: 'にんじん'
        fill_in 'product_price', with: 1_000
        fill_in 'product_description', with: '甘いです。'
        attach_file 'product_image', file_fixture('test_image.jpg')
        fill_in 'product_position', with: 1
        click_button '登録する'

        expect(page).to have_content '登録しました'
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
    let!(:product) { create(:product, name: 'にんじん', price: 1_000, description: '商品説明です。', position: 1) }

    context 'フォームの入力値が正常' do
      it '編集成功' do
        visit edit_admins_product_path(product)

        fill_in 'product_name', with: 'ピーマン'
        fill_in 'product_price', with: 2_000
        fill_in 'product_description', with: '苦いです。'
        attach_file 'product_image', file_fixture('test_image.jpg')
        fill_in 'product_position', with: 1
        click_button '変更する'

        expect(page).to have_content '変更しました'
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
      expect {
        expect(page.accept_confirm).to eq '本当に削除しますか？'
        expect(page).to have_content '削除しました'
      }.to change(Product, :count).by(-1)
    end
  end
end
