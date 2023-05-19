class Order < ApplicationRecord
  belongs_to :customer
  has_many :order_item
end

