ActiveRecord::Schema[7.2].define(version: 2026_05_14_000800) do
  create_table "users", force: :cascade do |t|
    t.string "name", null: false
    t.string "email", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.boolean "admin", default: false, null: false
    t.string "role", default: "operational", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  create_table "customers", force: :cascade do |t|
    t.string "name", null: false
    t.string "document"
    t.string "email"
    t.string "phone"
    t.string "city"
    t.string "state"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["document"], name: "index_customers_on_document", unique: true
  end

  create_table "products", force: :cascade do |t|
    t.string "name", null: false
    t.string "sku", null: false
    t.decimal "price", precision: 12, scale: 2, default: "0.0", null: false
    t.integer "minimum_stock", default: 0, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["sku"], name: "index_products_on_sku", unique: true
  end

  create_table "stock_movements", force: :cascade do |t|
    t.integer "product_id", null: false
    t.integer "kind", default: 0, null: false
    t.integer "quantity", null: false
    t.string "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["product_id"], name: "index_stock_movements_on_product_id"
  end

  create_table "orders", force: :cascade do |t|
    t.integer "customer_id", null: false
    t.integer "status", default: 0, null: false
    t.decimal "total", precision: 12, scale: 2, default: "0.0", null: false
    t.date "ordered_on", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["customer_id"], name: "index_orders_on_customer_id"
  end

  create_table "order_items", force: :cascade do |t|
    t.integer "order_id", null: false
    t.integer "product_id", null: false
    t.integer "quantity", null: false
    t.decimal "unit_price", precision: 12, scale: 2, null: false
    t.decimal "subtotal", precision: 12, scale: 2, default: "0.0", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["order_id"], name: "index_order_items_on_order_id"
    t.index ["product_id"], name: "index_order_items_on_product_id"
  end

  create_table "financial_entries", force: :cascade do |t|
    t.integer "order_id"
    t.string "description", null: false
    t.integer "kind", default: 0, null: false
    t.integer "status", default: 0, null: false
    t.decimal "amount", precision: 12, scale: 2, null: false
    t.date "due_on", null: false
    t.date "paid_on"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["order_id"], name: "index_financial_entries_on_order_id"
  end

  add_foreign_key "stock_movements", "products"
  add_foreign_key "orders", "customers"
  add_foreign_key "order_items", "orders"
  add_foreign_key "order_items", "products"
  add_foreign_key "financial_entries", "orders"
end
