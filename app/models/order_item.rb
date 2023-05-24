class OrderItem < ApplicationRecord
belongs_to :order
belongs_to :item
enum making_status: {before:0, waiting:1, making:2, finish:3}

end
