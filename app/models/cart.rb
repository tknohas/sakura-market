class Cart < ApplicationRecord
  belongs_to :user, optional: true # 次PRでセッションユーザーの対応
  has_many :cart_items, dependent: :destroy
  has_many :products, through: :cart_items

  validates :user_id, uniqueness: true
end
