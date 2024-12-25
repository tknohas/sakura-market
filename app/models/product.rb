class Product < ApplicationRecord
  has_many :cart_items, dependent: :destroy
  has_many :carts, through: :cart_items
  has_many :purchase_items, dependent: :destroy
  has_many :purchases, through: :purchase_items

  acts_as_list
  paginates_per 24

  has_one_attached :image do |attachable|
    attachable.variant :small, resize_to_limit: [120, 80], preprocessed: true
    attachable.variant :middle, resize_to_limit: [330, 219], preprocessed: true
    attachable.variant :large, resize_to_limit: [500, 333], preprocessed: true
  end

  validates :name, presence: true, length: { maximum: 50 }
  validates :price, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  validates :description, presence: true, length: { maximum: 200 }
  validates :position, numericality: { only_integer: true, allow_nil: true, greater_than_or_equal_to: 0 }

  scope :order_by_position, -> { order(:position) }
  scope :published, -> { where.not(published_at: nil) }
end
