# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20141217195131) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "active_admin_comments", force: true do |t|
    t.string   "namespace"
    t.text     "body"
    t.string   "resource_id",   null: false
    t.string   "resource_type", null: false
    t.integer  "author_id"
    t.string   "author_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "active_admin_comments", ["author_type", "author_id"], name: "index_active_admin_comments_on_author_type_and_author_id", using: :btree
  add_index "active_admin_comments", ["namespace"], name: "index_active_admin_comments_on_namespace", using: :btree
  add_index "active_admin_comments", ["resource_type", "resource_id"], name: "index_active_admin_comments_on_resource_type_and_resource_id", using: :btree

  create_table "admin_users", force: true do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "admin_users", ["email"], name: "index_admin_users_on_email", unique: true, using: :btree
  add_index "admin_users", ["reset_password_token"], name: "index_admin_users_on_reset_password_token", unique: true, using: :btree

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

  create_table "v1_brand_names", force: true do |t|
    t.string  "name"
    t.integer "category_name_id"
  end

  create_table "v1_brands", force: true do |t|
    t.integer "brand_name_id"
    t.integer "category_id"
  end

  create_table "v1_buyers", force: true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "api_key"
    t.string   "name"
    t.string   "phone"
  end

  create_table "v1_categories", force: true do |t|
    t.integer "category_name_id"
    t.integer "seller_id"
  end

  create_table "v1_category_names", force: true do |t|
    t.string "name"
    t.string "variants", array: true
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
    t.integer  "status",          default: 0
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
    t.integer  "status",           default: 0
  end

  add_index "v1_quotes", ["seller_ids"], name: "index_v1_quotes_on_seller_ids", using: :gin

  create_table "v1_sellers", force: true do |t|
    t.string   "api_key"
    t.text     "address"
    t.decimal  "latitude",        precision: 10, scale: 6, default: -1000.0, null: false
    t.decimal  "longitude",       precision: 10, scale: 6, default: -1000.0, null: false
    t.string   "phone"
    t.integer  "rating",                                   default: -1,      null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "name_of_shop"
    t.string   "name_of_seller"
    t.string   "email",                                    default: "",      null: false
    t.string   "password_digest"
    t.integer  "status",                                   default: 0
  end

  create_table "v1_visitors", force: true do |t|
    t.string   "name"
    t.string   "phone"
    t.string   "email"
    t.text     "message"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
