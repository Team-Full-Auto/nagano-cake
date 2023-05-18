class Order < ApplicationRecord
  has_many :orders
  
  belong
end
