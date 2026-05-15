class CreateOrders < ActiveRecord::Migration[7.2]
  def change
    create_table :orders do |t|
      t.references :customer, null: false, foreign_key: true
      t.integer :status, null: false, default: 0
      t.decimal :total, precision: 12, scale: 2, null: false, default: 0
      t.date :ordered_on, null: false

      t.timestamps
    end
  end
end
