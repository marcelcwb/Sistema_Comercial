class CreateProducts < ActiveRecord::Migration[7.2]
  def change
    create_table :products do |t|
      t.string :name, null: false
      t.string :sku, null: false
      t.decimal :price, precision: 12, scale: 2, null: false, default: 0
      t.integer :minimum_stock, null: false, default: 0

      t.timestamps
    end

    add_index :products, :sku, unique: true
  end
end
