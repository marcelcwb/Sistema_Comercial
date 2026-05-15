class CreateFinancialEntries < ActiveRecord::Migration[7.2]
  def change
    create_table :financial_entries do |t|
      t.references :order, foreign_key: true
      t.string :description, null: false
      t.integer :kind, null: false, default: 0
      t.integer :status, null: false, default: 0
      t.decimal :amount, precision: 12, scale: 2, null: false
      t.date :due_on, null: false
      t.date :paid_on

      t.timestamps
    end
  end
end
