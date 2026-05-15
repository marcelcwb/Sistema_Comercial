class CreateStockMovements < ActiveRecord::Migration[7.2]
  def change
    create_table :stock_movements do |t|
      t.references :product, null: false, foreign_key: true
      t.integer :kind, null: false, default: 0
      t.integer :quantity, null: false
      t.string :description

      t.timestamps
    end
  end
end
