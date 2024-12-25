class Cart < ApplicationRecord
  belongs_to :user, optional: true
  has_many :cart_items, dependent: :destroy
  has_many :products, through: :cart_items

  TAX_RATE = 1.1
  BASE_SHIPPING_FEE = 600
  ITEM_PER_TIER = 5

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

  def subtotal
    cart_items.sum(&:total_price)
  end

  def cash_on_delivery_fee
    case subtotal
    when 0...10000
      300
    when 10000...30000
      400
    when 30000...100000
      600
    else
      1000
    end
  end

  def calculate_shipping_fee
    BASE_SHIPPING_FEE * (cart_items.sum(:quantity) / ITEM_PER_TIER.to_f).ceil
  end

  def total_exclude_tax
    subtotal + cash_on_delivery_fee + calculate_shipping_fee
  end

  def total_price
    (total_exclude_tax * TAX_RATE).round
  end

  def tax_price
    total_price - total_exclude_tax
  end

  def clear
    cart_items.destroy_all
  end

  DELIVERY_TIME_OPTIONS = %w[
    指定なし
    8:00~12:00
    12:00~14:00
    14:00~16:00
    16:00~18:00
    18:00~20:00
    20:00~21:00
  ].map { |time| [time, time] }.freeze

  def delivery_time_options
    DELIVERY_TIME_OPTIONS
  end
end
