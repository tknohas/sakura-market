class CreateAddresses < ActiveRecord::Migration[8.0]
  def change
    create_table :addresses do |t|
      t.references :user, null: false, foreign_key: true, index: { unique: true }
      t.string :zip_code, null: false
      t.string :prefecture, null: false
      t.string :city, null: false
      t.string :street, null: false
      t.string :building, null: false

      t.timestamps
    end
  end
end
