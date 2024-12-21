class CreateCartItems < ActiveRecord::Migration[8.0]
  def change
    create_table :cart_items do |t|
      t.references :product, null: false, foreign_key: true
      t.references :cart, null: false, foreign_key: true
      t.integer :quantity, null: false, default: 0

      t.timestamps
    end
    add_index :cart_items, [:product_id, :cart_id], unique: true
  end
end
