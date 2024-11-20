module LoginModule
  def admin_login(admin)
    visit new_admin_session_path

    fill_in 'admin_email', with: admin.email
    fill_in 'admin_password', with: admin.password
    click_button 'ログイン'
  end

  def user_login(user)
    visit new_user_session_path

    fill_in 'user_email', with: user.email
    fill_in 'user_password', with: user.password
    click_button 'ログイン'
  end
end
