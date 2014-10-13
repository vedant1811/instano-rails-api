class CreateInitialTables < ActiveRecord::Migration
  def change

    create_table "delayed_jobs", force: true do |t|
    t.integer  "priority",   default: 0, null: false
    t.integer  "attempts",   default: 0, null: false
    t.text     "handler",                null: false
    t.text     "last_error"
    t.datetime "run_at"
    t.datetime "locked_at"
    t.datetime "failed_at"
    t.string   "locked_by"
    t.string   "queue"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "delayed_jobs", ["priority", "run_at"], name: "delayed_jobs_priority", using: :btree

  create_table "v1_brand_categories", force: true do |t|
    t.integer "brand_id"
    t.integer "category_id"
    t.integer "seller_id"
  end

  create_table "v1_brands", force: true do |t|
    t.string "name"
  end

  create_table "v1_buyers", force: true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "v1_categories", force: true do |t|
    t.string "name"
  end

  create_table "v1_devices", force: true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "v1_quotations", force: true do |t|
    t.string   "name_of_product",              null: false
    t.integer  "price",                        null: false
    t.text     "description",     default: "", null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "quote_id",                     null: false
    t.integer  "seller_id",                    null: false
  end

  create_table "v1_quotes", force: true do |t|
    t.integer  "buyer_id",                       null: false
    t.string   "search_string",                  null: false
    t.string   "brands",           default: "",  null: false
    t.string   "price_range",      default: "",  null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "product_category", default: 0,   null: false
    t.integer  "seller_ids",       default: [0], null: false, array: true
  end

  add_index "v1_quotes", ["seller_ids"], name: "index_v1_quotes_on_seller_ids", using: :gin

  create_table "v1_sellers", force: true do |t|
    t.string   "api_key"
    t.text     "address",                                                        null: false
    t.decimal  "latitude",            precision: 10, scale: 6, default: -1000.0, null: false
    t.decimal  "longitude",           precision: 10, scale: 6, default: -1000.0, null: false
    t.string   "phone",                                                          null: false
    t.integer  "rating",                                       default: -1,      null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "name_of_shop",                                                   null: false
    t.string   "name_of_seller",                                                 null: false
    t.string   "email",                                        default: "",      null: false
    t.string   "password_digest"
    t.integer  "brand_categories_id"
  end

  add_index "v1_sellers", ["brand_categories_id"], name: "index_v1_sellers_on_brand_categories_id", using: :btree
  add_index "v1_sellers", ["email"], name: "index_v1_sellers_on_email", unique: true, using: :btree

  create_table "v1_visitors", force: true do |t|
    t.string   "name"
    t.string   "phone"
    t.string   "email"
    t.text     "message"
    t.datetime "created_at"
    t.datetime "updated_at"
  end
  end
end
