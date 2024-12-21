class User < ApplicationRecord
  has_one :address, dependent: :destroy
  has_one :cart, dependent: :destroy

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :name, presence: true, length: { maximum: 20 }
end
