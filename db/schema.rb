# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[8.1].define(version: 2026_03_13_000120) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "pg_catalog.plpgsql"

  create_table "order_items", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.bigint "order_id", null: false
    t.decimal "price_at_purchase"
    t.bigint "product_variant_id", null: false
    t.integer "quantity"
    t.datetime "updated_at", null: false
    t.index ["order_id"], name: "index_order_items_on_order_id"
    t.index ["product_variant_id"], name: "index_order_items_on_product_variant_id"
  end

  create_table "orders", force: :cascade do |t|
    t.decimal "bulky_total", precision: 10, scale: 2
    t.datetime "created_at", null: false
    t.string "payment_status"
    t.string "paypal_capture_id"
    t.string "paypal_order_id"
    t.decimal "shipping_total", precision: 10, scale: 2
    t.string "status"
    t.decimal "subtotal", precision: 10, scale: 2
    t.decimal "tax_total", precision: 10, scale: 2
    t.decimal "total"
    t.datetime "updated_at", null: false
    t.bigint "user_id", null: false
    t.index ["user_id"], name: "index_orders_on_user_id"
  end

  create_table "product_variants", force: :cascade do |t|
    t.boolean "active", default: true
    t.boolean "bulky", default: false, null: false
    t.datetime "created_at", null: false
    t.string "name", null: false
    t.decimal "price_override", precision: 8, scale: 2
    t.bigint "product_id", null: false
    t.integer "stock"
    t.datetime "updated_at", null: false
    t.decimal "weight_ounces", precision: 8, scale: 2
    t.index ["product_id"], name: "index_product_variants_on_product_id"
  end

  create_table "products", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.text "description"
    t.boolean "featured"
    t.decimal "handling_fee", precision: 8, scale: 2
    t.string "image_alt_key"
    t.string "image_key"
    t.decimal "margin_percent", precision: 5, scale: 2
    t.string "name"
    t.decimal "price"
    t.boolean "price_hidden", default: true, null: false
    t.string "slug"
    t.datetime "updated_at", null: false
    t.index ["slug"], name: "index_products_on_slug"
  end

  create_table "tax_rates", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.decimal "rate", precision: 6, scale: 5, default: "0.0", null: false
    t.string "state", null: false
    t.datetime "updated_at", null: false
    t.index ["state"], name: "index_tax_rates_on_state", unique: true
  end

  create_table "users", force: :cascade do |t|
    t.boolean "admin", default: false, null: false
    t.datetime "created_at", null: false
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.datetime "remember_created_at"
    t.datetime "reset_password_sent_at"
    t.string "reset_password_token"
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  create_table "vendor_products", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.integer "lead_time_days"
    t.integer "min_order_quantity"
    t.decimal "msrp", precision: 8, scale: 2
    t.text "notes"
    t.datetime "price_updated_at"
    t.bigint "product_variant_id", null: false
    t.decimal "unit_cost", precision: 8, scale: 2
    t.datetime "updated_at", null: false
    t.bigint "vendor_id", null: false
    t.string "vendor_sku"
    t.index ["product_variant_id"], name: "index_vendor_products_on_product_variant_id"
    t.index ["vendor_id", "product_variant_id"], name: "index_vendor_products_on_vendor_id_and_product_variant_id", unique: true
    t.index ["vendor_id"], name: "index_vendor_products_on_vendor_id"
  end

  create_table "vendors", force: :cascade do |t|
    t.boolean "active", default: true, null: false
    t.string "contact_name"
    t.datetime "created_at", null: false
    t.string "email"
    t.string "name", null: false
    t.text "notes"
    t.string "phone"
    t.datetime "updated_at", null: false
    t.string "website"
  end

  add_foreign_key "order_items", "orders"
  add_foreign_key "order_items", "product_variants"
  add_foreign_key "orders", "users"
  add_foreign_key "product_variants", "products"
  add_foreign_key "vendor_products", "product_variants"
  add_foreign_key "vendor_products", "vendors"
end
