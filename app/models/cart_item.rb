class CartItem < ApplicationRecord
  belongs_to :product
  belongs_to :cart

  validates :product_id, { uniqueness: { scope: :cart_id } }
  validates :quantity, numericality: { only_integer: true, greater_than: 0 }, presence: true

  def total_price
    product.price * quantity
  end
end
