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

ActiveRecord::Schema[7.0].define(version: 2022_11_20_175058) do
  create_table "bikes", charset: "utf8mb4", collation: "utf8mb4_general_ci", force: :cascade do |t|
    t.string "identifier"
    t.string "current_station_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "status", limit: 1, default: 0, null: false
    t.string "current_user_id"
    t.index ["identifier"], name: "index_bikes_on_identifier", unique: true
  end

  create_table "pay_charges", charset: "utf8mb4", collation: "utf8mb4_general_ci", force: :cascade do |t|
    t.string "identifier", null: false
    t.bigint "customer_id", null: false
    t.bigint "subscription_id"
    t.string "processor_id", null: false
    t.integer "amount", null: false
    t.string "currency"
    t.integer "application_fee_amount"
    t.integer "amount_refunded"
    t.text "metadata", size: :long, collation: "utf8mb4_bin"
    t.text "data", size: :long, collation: "utf8mb4_bin"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["customer_id", "processor_id"], name: "index_pay_charges_on_customer_id_and_processor_id", unique: true
    t.index ["identifier"], name: "index_pay_charges_on_identifier"
    t.index ["subscription_id"], name: "index_pay_charges_on_subscription_id"
    t.check_constraint "json_valid(`data`)", name: "data"
    t.check_constraint "json_valid(`metadata`)", name: "metadata"
  end

  create_table "pay_customers", charset: "utf8mb4", collation: "utf8mb4_general_ci", force: :cascade do |t|
    t.string "identifier", null: false
    t.string "owner_type"
    t.bigint "owner_id"
    t.string "processor", null: false
    t.string "processor_id"
    t.boolean "default"
    t.text "data", size: :long, collation: "utf8mb4_bin"
    t.datetime "deleted_at", precision: nil
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["identifier"], name: "index_pay_customers_on_identifier"
    t.index ["owner_type", "owner_id", "deleted_at", "default"], name: "pay_customer_owner_index"
    t.index ["processor", "processor_id"], name: "index_pay_customers_on_processor_and_processor_id", unique: true
    t.check_constraint "json_valid(`data`)", name: "data"
  end

  create_table "pay_merchants", charset: "utf8mb4", collation: "utf8mb4_general_ci", force: :cascade do |t|
    t.string "identifier", null: false
    t.string "owner_type"
    t.bigint "owner_id"
    t.string "processor", null: false
    t.string "processor_id"
    t.boolean "default"
    t.text "data", size: :long, collation: "utf8mb4_bin"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["identifier"], name: "index_pay_merchants_on_identifier"
    t.index ["owner_type", "owner_id", "processor"], name: "index_pay_merchants_on_owner_type_and_owner_id_and_processor"
    t.check_constraint "json_valid(`data`)", name: "data"
  end

  create_table "pay_payment_methods", charset: "utf8mb4", collation: "utf8mb4_general_ci", force: :cascade do |t|
    t.string "identifier", null: false
    t.bigint "customer_id", null: false
    t.string "processor_id", null: false
    t.boolean "default"
    t.string "type"
    t.text "data", size: :long, collation: "utf8mb4_bin"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["customer_id", "processor_id"], name: "index_pay_payment_methods_on_customer_id_and_processor_id", unique: true
    t.index ["identifier"], name: "index_pay_payment_methods_on_identifier"
    t.check_constraint "json_valid(`data`)", name: "data"
  end

  create_table "pay_subscriptions", charset: "utf8mb4", collation: "utf8mb4_general_ci", force: :cascade do |t|
    t.string "identifier", null: false
    t.bigint "customer_id", null: false
    t.string "name", null: false
    t.string "processor_id", null: false
    t.string "processor_plan", null: false
    t.integer "quantity", default: 1, null: false
    t.string "status", null: false
    t.datetime "trial_ends_at", precision: nil
    t.datetime "ends_at", precision: nil
    t.decimal "application_fee_percent", precision: 8, scale: 2
    t.text "metadata", size: :long, collation: "utf8mb4_bin"
    t.text "data", size: :long, collation: "utf8mb4_bin"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["customer_id", "processor_id"], name: "index_pay_subscriptions_on_customer_id_and_processor_id", unique: true
    t.index ["identifier"], name: "index_pay_subscriptions_on_identifier"
    t.check_constraint "json_valid(`data`)", name: "data"
    t.check_constraint "json_valid(`metadata`)", name: "metadata"
  end

  create_table "pay_webhooks", charset: "utf8mb4", collation: "utf8mb4_general_ci", force: :cascade do |t|
    t.string "identifier", null: false
    t.string "processor"
    t.string "event_type"
    t.text "event", size: :long, collation: "utf8mb4_bin"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["identifier"], name: "index_pay_webhooks_on_identifier"
    t.check_constraint "json_valid(`event`)", name: "event"
  end

  create_table "stations", charset: "utf8mb4", collation: "utf8mb4_general_ci", force: :cascade do |t|
    t.string "identifier"
    t.string "name"
    t.string "address"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.float "latitude", default: 0.0, null: false
    t.float "longitude", default: 0.0, null: false
    t.integer "capacity", limit: 1, default: 0, null: false
    t.index ["identifier"], name: "index_stations_on_identifier", unique: true
  end

  create_table "users", charset: "utf8mb4", collation: "utf8mb4_general_ci", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "identifier", null: false
    t.string "first_name", default: "", null: false
    t.string "last_name", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["identifier"], name: "index_users_on_identifier", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "pay_charges", "pay_customers", column: "customer_id"
  add_foreign_key "pay_charges", "pay_subscriptions", column: "subscription_id"
  add_foreign_key "pay_payment_methods", "pay_customers", column: "customer_id"
  add_foreign_key "pay_subscriptions", "pay_customers", column: "customer_id"
end
