RSpec.describe 'Products', type: :system do
  let!(:admin) { create(:admin) }

  describe 'ログイン' do
    before do
      admin_login(admin)
    end

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
end
