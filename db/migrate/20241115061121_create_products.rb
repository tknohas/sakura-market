class CreateProducts < ActiveRecord::Migration[8.0]
  def change
    create_table :products do |t|
      t.string :name, null: false
      t.integer :price, null: false, default: 0
      t.text :description, null: false
      t.datetime :published_at
      t.integer :position, null: false

      t.timestamps
    end
  end
end
