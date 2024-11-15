module LoginModule
  def admin_login(admin)
    visit new_admin_session_path

    fill_in 'admin_email', with: admin.email
    fill_in 'admin_password', with: admin.password
    within '.actions' do
      click_button 'ログイン'
    end
  end
end
