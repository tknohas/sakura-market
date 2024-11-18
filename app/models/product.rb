class Product < ApplicationRecord
  acts_as_list

  has_one_attached :image do |attachable|
    attachable.variant :small, resize_to_limit: [120, 80], preprocessed: true
    attachable.variant :middle, resize_to_limit: [330, 219], preprocessed: true
    attachable.variant :large, resize_to_limit: [500, 333], preprocessed: true
  end

  validates :name, presence: true, length: { maximum: 50 }
  validates :price, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  validates :description, presence: true, length: { maximum: 200 }
  validates :position, numericality: { only_integer: true, greater_than_or_equal_to: 0 }

  scope :order_by_position, -> { order(:position) }
end
