class Item < ApplicationRecord
  belongs_to :genre
  has_many :cart_items, dependent: :destroy
  has_many :order_items, dependent: :destroy

  has_one_attached :image

  validates :image, presence: true
  validates :name, presence: true
  validates :detail, presence: true
  validates :genre_id, presence: true
  # 値段設定時、半角数字のみ登録可能にするバリデーション
  validates :price, presence: true, format: {
    with: /\A[0-9]+\z/i,
  }

  # 税込価格を求めるメソッド
  def with_tax_price
    (price * 1.1).floor
  end
  
  scope :recent_items, -> { order(created_at: :desc).limit(4) }
end
