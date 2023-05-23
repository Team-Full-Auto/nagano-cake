class Customer < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :cart_items, dependent: :destroy
  has_many :orders, dependent: :destroy
  has_many :shipping_addresses, dependent: :destroy

  validates :email, uniqueness: true
  validates :phone_number, uniqueness: true

  def active_for_authentication?
    super && (is_deleted == false)
  end
end