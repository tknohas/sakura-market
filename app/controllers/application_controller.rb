class ApplicationController < ActionController::Base
  before_action :authenticate_user!
  helper_method :current_cart

  def current_cart
    if user_signed_in?
      current_cart = current_user.cart || current_user.create_cart!
    else
      current_cart = Cart.find_or_create_by!(id: session[:cart_id])
      session[:cart_id] ||= current_cart.id
    end
    current_cart
  end
end
