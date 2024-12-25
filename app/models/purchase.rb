class Purchase < ApplicationRecord
  belongs_to :user
  has_many :purchase_items, dependent: :destroy
  has_many :products, through: :purchase_items

  MINIMUM_DELIVERY_DAYS = 3
  MAXIMUM_DELIVERY_DAYS = 14

  before_create :set_financial_attributes

  validate :delivery_date_should_be_within_valid_range

  def set_financial_attributes
    assign_attributes(
      subtotal: user.cart.subtotal,
      shipping_fee: user.cart.calculate_shipping_fee,
      delivery_fee: user.cart.cash_on_delivery_fee,
      tax: user.cart.tax_price,
      tax_rate: Cart::TAX_RATE,
      total_price: user.cart.total_price
    )
  end

  def complete!
    transaction do
      user.cart.cart_items.each do |cart_item|
        purchase_items.build(
          product_id: cart_item.product_id,
          quantity: cart_item.quantity,
          price: cart_item.product.price,
          name: cart_item.product.name
        )
      end
      save!
    end
  end

  private

  def delivery_date_should_be_within_valid_range
    return unless delivery_on.present?

    unless delivery_on.between?(MINIMUM_DELIVERY_DAYS.business_days.after(Date.current), MAXIMUM_DELIVERY_DAYS.business_days.after(Date.current))
      errors.add(:delivery_on, 'は3営業日から14営業日までの範囲で指定可能です。')
    end
  end
end
