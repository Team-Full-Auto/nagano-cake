class CreateOrders < ActiveRecord::Migration[6.1]
  def change
    create_table :orders do |t|
      t.references :customer, foreign_key: true, null: false
      t.integer :postage, default: 800, null: false
      t.integer :payment, null: false
      t.integer :pay_method, default: 0, null: false
      t.integer :status, default: 0, null: false
      t.text :address, null: false
      t.string :postcode, null: false
      t.string :address_name, null: false

      t.timestamps
    end
  end
end
