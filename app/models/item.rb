class Item < ApplicationRecord
  belongs_to :genre
  has_many :cart_items, dependent: :destroy
  has_many :order_items, dependent: :destroy

  has_one_attached :image
  
  # 税込価格を求めるメソッド
  def with_tax_price
    (price * 1.1).floor
  end 
end
