class Users::SessionsController < Devise::SessionsController
  after_action :merge_cart, only: %i[create]

  def after_sign_in_path_for(_resource)
    root_path
  end

  def after_sign_out_path_for(_resource)
    new_user_session_path
  end

  private

  def merge_cart
    return unless session[:cart_id]

    session_cart = Cart.find_by!(id: session[:cart_id])
    current_cart.merge_cart(session_cart)
  end
end
