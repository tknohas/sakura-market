class CreatePurchaseItems < ActiveRecord::Migration[8.0]
  def change
    create_table :purchase_items do |t|
      t.references :purchase, null: false, foreign_key: true
      t.references :product, null: false, foreign_key: true
      t.integer :quantity, null: false, default: 0
      t.integer :price, null: false, default: 0
      t.string :name, null: false

      t.timestamps
    end
    add_index :purchase_items, %i[purchase_id product_id], unique: true
  end
end
