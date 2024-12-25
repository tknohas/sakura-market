class CreatePurchases < ActiveRecord::Migration[8.0]
  def change
    create_table :purchases do |t|
      t.references :user, null: false, foreign_key: true
      t.integer :subtotal, null: false
      t.integer :shipping_fee, null: false
      t.integer :delivery_fee, null: false
      t.integer :tax, null: false
      t.float :tax_rate, null: false
      t.integer :total_price, null: false
      t.date :delivery_on
      t.string :delivery_time

      t.timestamps
    end
  end
end
