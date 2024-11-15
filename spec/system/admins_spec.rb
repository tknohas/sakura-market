RSpec.describe 'Admins', type: :system do
  let(:admin) { create(:admin) }

  describe 'ログイン' do
    before do
      visit new_admin_session_path
    end

    context 'フォームの入力値が正常' do
      it 'ログイン成功' do
        fill_in 'admin_email', with: admin.email
        fill_in 'admin_password', with: admin.password
        within '.actions' do
          click_button 'ログイン'
        end

        expect(page).to have_content 'ログインしました'
      end
    end

    context 'フォームの入力値が異常' do
      it 'ログイン失敗' do
        fill_in 'admin_email', with: ''
        fill_in 'admin_password', with: ''
        within '.actions' do
          click_button 'ログイン'
        end

        expect(page).to have_content 'メールアドレスまたはパスワードが違います。'
      end
    end

    it 'ログアウトできる' do
      admin_login(admin)

      click_on 'ログアウト'
      expect(page).to have_content 'ログアウトしました。'
    end
  end
end