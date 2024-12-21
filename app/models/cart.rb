class Cart < ApplicationRecord
  belongs_to :user, optional: true
  has_many :cart_items, dependent: :destroy
  has_many :products, through: :cart_items

  def merge_cart(session_cart)
    return unless session_cart

    transaction do
      session_cart.cart_items.each do |cart_item|
        existing_item = cart_items.find_or_initialize_by(product_id: cart_item.product_id)
        existing_item.quantity += cart_item.quantity
        existing_item.save!
      end
    end
  end
end
