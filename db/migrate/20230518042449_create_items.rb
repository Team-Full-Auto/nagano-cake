class CreateItems < ActiveRecord::Migration[6.1]
  def change
    create_table :items do |t|
      t.references :genre, foreign_key: true,  null: false
      t.string :name, null: false
      t.text :detail, null: false
      t.integer :price, null: false
      t.boolean :is_selling, default: true, null: false
      t.timestamps
    end
  end
end
