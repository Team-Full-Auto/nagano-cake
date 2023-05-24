class Order < ApplicationRecord
  belongs_to :customer
  has_many :order_items, dependent: :destroy
  
 

  enum status: {
     before_payment:0,
     confirm_payment:1,
     making:2,
     before_sending:3,
     sent:4
  }
enum payment_method: { credit_card: 0, transfer: 1 }
end

