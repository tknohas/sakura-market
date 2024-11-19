class Address < ApplicationRecord
  belongs_to :user

  validates :zip_code, presence: true, length: { maximum: 8 }, format: { with: /\A\d{3}-\d{4}\z/ }
  validates :prefecture, presence: true, length: { maximum: 4 }, format: { with: /\A.+[都道府県]\z/, message: 'まで入力してください' }
  validates :city, presence: true, length: { maximum: 50 }
  validates :street, presence: true, length: { maximum: 100 }
  validates :building, length: { maximum: 100 }
end
