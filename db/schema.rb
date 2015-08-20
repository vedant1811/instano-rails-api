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

ActiveRecord::Schema.define(version: 20150514082437) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "active_admin_comments", force: :cascade do |t|
    t.string   "namespace",     limit: 255
    t.text     "body"
    t.string   "resource_id",   limit: 255, null: false
    t.string   "resource_type", limit: 255, null: false
    t.integer  "author_id"
    t.string   "author_type",   limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "active_admin_comments", ["author_type", "author_id"], name: "index_active_admin_comments_on_author_type_and_author_id", using: :btree
  add_index "active_admin_comments", ["namespace"], name: "index_active_admin_comments_on_namespace", using: :btree
  add_index "active_admin_comments", ["resource_type", "resource_id"], name: "index_active_admin_comments_on_resource_type_and_resource_id", using: :btree

  create_table "admin_users", force: :cascade do |t|
    t.string   "email",                  limit: 255, default: "", null: false
    t.string   "encrypted_password",     limit: 255, default: "", null: false
    t.string   "reset_password_token",   limit: 255
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                      default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "admin_users", ["email"], name: "index_admin_users_on_email", unique: true, using: :btree
  add_index "admin_users", ["reset_password_token"], name: "index_admin_users_on_reset_password_token", unique: true, using: :btree

  create_table "delayed_jobs", force: :cascade do |t|
    t.integer  "priority",               default: 0, null: false
    t.integer  "attempts",               default: 0, null: false
    t.text     "handler",                            null: false
    t.text     "last_error"
    t.datetime "run_at"
    t.datetime "locked_at"
    t.datetime "failed_at"
    t.string   "locked_by",  limit: 255
    t.string   "queue",      limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "delayed_jobs", ["priority", "run_at"], name: "delayed_jobs_priority", using: :btree

  create_table "outlets", force: :cascade do |t|
    t.string   "phone",      limit: 255
    t.string   "email",      limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "rpush_apps", force: :cascade do |t|
    t.string   "name",                    limit: 255,             null: false
    t.string   "environment",             limit: 255
    t.text     "certificate"
    t.string   "password",                limit: 255
    t.integer  "connections",                         default: 1, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "type",                    limit: 255,             null: false
    t.string   "auth_key",                limit: 255
    t.string   "client_id",               limit: 255
    t.string   "client_secret",           limit: 255
    t.string   "access_token",            limit: 255
    t.datetime "access_token_expiration"
  end

  create_table "rpush_feedback", force: :cascade do |t|
    t.string   "device_token", limit: 64, null: false
    t.datetime "failed_at",               null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "app_id"
  end

  add_index "rpush_feedback", ["device_token"], name: "index_rpush_feedback_on_device_token", using: :btree

  create_table "rpush_notifications", force: :cascade do |t|
    t.integer  "badge"
    t.string   "device_token",      limit: 64
    t.string   "sound",             limit: 255, default: "default"
    t.string   "alert",             limit: 255
    t.text     "data"
    t.integer  "expiry",                        default: 86400
    t.boolean  "delivered",                     default: false,     null: false
    t.datetime "delivered_at"
    t.boolean  "failed",                        default: false,     null: false
    t.datetime "failed_at"
    t.integer  "error_code"
    t.text     "error_description"
    t.datetime "deliver_after"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "alert_is_json",                 default: false
    t.string   "type",              limit: 255,                     null: false
    t.string   "collapse_key",      limit: 255
    t.boolean  "delay_while_idle",              default: false,     null: false
    t.text     "registration_ids"
    t.integer  "app_id",                                            null: false
    t.integer  "retries",                       default: 0
    t.string   "uri",               limit: 255
    t.datetime "fail_after"
    t.boolean  "processing",                    default: false,     null: false
    t.integer  "priority"
    t.text     "url_args"
    t.string   "category",          limit: 255
  end

  add_index "rpush_notifications", ["delivered", "failed"], name: "index_rpush_notifications_multi", where: "((NOT delivered) AND (NOT failed))", using: :btree

  create_table "v1_bookings", force: :cascade do |t|
    t.integer  "status",       default: 0,                     null: false
    t.integer  "price",                                        null: false
    t.integer  "buyer_id",                                     null: false
    t.integer  "quotation_id"
    t.integer  "deal_id"
    t.datetime "expires_at",   default: '2015-05-16 10:30:59', null: false
    t.datetime "created_at",                                   null: false
    t.datetime "updated_at",                                   null: false
  end

  create_table "v1_brand_names", force: :cascade do |t|
    t.string  "name",             limit: 255
    t.integer "category_name_id"
  end

  add_index "v1_brand_names", ["category_name_id", "name"], name: "index_v1_brand_names_on_category_name_id_and_name", unique: true, using: :btree

  create_table "v1_brands", force: :cascade do |t|
    t.integer "brand_name_id"
    t.integer "seller_id",     null: false
  end

  add_index "v1_brands", ["seller_id", "brand_name_id"], name: "index_v1_brands_on_seller_id_and_brand_name_id", unique: true, using: :btree

  create_table "v1_buyers", force: :cascade do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "name",             limit: 255
    t.string   "phone",            limit: 255
    t.integer  "facebook_user_id"
  end

  create_table "v1_category_names", force: :cascade do |t|
    t.string "name",     limit: 255
    t.string "variants",             array: true
  end

  create_table "v1_deals", force: :cascade do |t|
    t.string   "heading",    limit: 255, null: false
    t.string   "subheading", limit: 255
    t.datetime "expires_at",             null: false
    t.integer  "seller_id",              null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "product_id"
  end

  create_table "v1_devices", force: :cascade do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "gcm_registration_id", limit: 255, default: "Illegal state", null: false
    t.string   "session_id",          limit: 255
    t.integer  "buyer_id"
    t.integer  "seller_id"
    t.integer  "gcm_status",                      default: 0
  end

  create_table "v1_facebook_users", force: :cascade do |t|
    t.string   "user_id",         null: false
    t.string   "name",            null: false
    t.string   "email"
    t.boolean  "verified"
    t.string   "gender"
    t.datetime "user_updated_at"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  create_table "v1_online_buyers", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.string   "phone",      limit: 255
    t.string   "url",        limit: 255
    t.string   "message",    limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "username",   limit: 255
  end

  create_table "v1_outlets", force: :cascade do |t|
    t.integer "seller_id",                                        null: false
    t.string  "address",                                          null: false
    t.decimal "latitude",    precision: 10, scale: 6
    t.decimal "longitude",   precision: 10, scale: 6
    t.string  "seller_name"
    t.string  "phone"
    t.integer "status",                               default: 0, null: false
  end

  create_table "v1_products", force: :cascade do |t|
    t.string   "name",               limit: 255,             null: false
    t.integer  "brand_name_id"
    t.string   "image_file_name",    limit: 255
    t.string   "image_content_type", limit: 255
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
    t.integer  "status",                         default: 0, null: false
    t.integer  "device_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "mrp"
    t.integer  "their_price",                                null: false
    t.string   "url",                                        null: false
    t.text     "features"
  end

  add_index "v1_products", ["name"], name: "index_v1_products_on_name", unique: true, using: :btree

  create_table "v1_quotations", force: :cascade do |t|
    t.integer  "price",                    null: false
    t.text     "description", default: "", null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "seller_id",                null: false
    t.integer  "status",      default: 0
    t.integer  "product_id",               null: false
  end

  create_table "v1_quotes", force: :cascade do |t|
    t.integer  "buyer_id",                                                    null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "status",                                          default: 0
    t.string   "address",    limit: 255
    t.decimal  "latitude",               precision: 10, scale: 6
    t.decimal  "longitude",              precision: 10, scale: 6
    t.integer  "product_id",                                                  null: false
  end

  create_table "v1_sellers", force: :cascade do |t|
    t.string   "api_key",            limit: 255
    t.string   "phone",              limit: 255
    t.integer  "rating",                         default: -1, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "name_of_shop",       limit: 255
    t.string   "email",              limit: 255, default: "", null: false
    t.string   "password_digest",    limit: 255
    t.integer  "status",                         default: 0
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
    t.text     "description"
  end

  create_table "v1_visitors", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.string   "phone",      limit: 255
    t.string   "email",      limit: 255
    t.text     "message"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "versions", force: :cascade do |t|
    t.string   "item_type",      limit: 255, null: false
    t.integer  "item_id",                    null: false
    t.string   "event",          limit: 255, null: false
    t.string   "whodunnit",      limit: 255
    t.text     "object"
    t.datetime "created_at"
    t.text     "object_changes"
  end

  add_index "versions", ["item_type", "item_id"], name: "index_versions_on_item_type_and_item_id", using: :btree

end
