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

ActiveRecord::Schema.define(version: 20150127011227) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "boxes", force: true do |t|
    t.string   "order_number"
    t.integer  "status"
    t.integer  "user_id"
    t.integer  "child_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "boxes", ["child_id"], name: "index_boxes_on_child_id", using: :btree
  add_index "boxes", ["user_id"], name: "index_boxes_on_user_id", using: :btree

  create_table "children", force: true do |t|
    t.string   "name"
    t.integer  "age_yrs"
    t.integer  "age_months"
    t.string   "gender"
    t.integer  "style"
    t.integer  "shirt_size"
    t.integer  "pant_size"
    t.integer  "jacket_size"
    t.integer  "shoe_size"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "children", ["user_id"], name: "index_children_on_user_id", using: :btree

  create_table "products", force: true do |t|
    t.string   "name"
    t.integer  "price"
    t.string   "color"
    t.string   "style"
    t.string   "image_url"
    t.string   "description"
    t.integer  "shirt_size"
    t.integer  "pants_size"
    t.integer  "jacket_size"
    t.integer  "shoe_size"
    t.string   "sku"
    t.string   "brand"
    t.integer  "box_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "products", ["box_id"], name: "index_products_on_box_id", using: :btree

  create_table "users", force: true do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.string   "ship_address_1"
    t.string   "ship_address_2"
    t.string   "ship_city"
    t.string   "ship_state"
    t.integer  "ship_zip"
    t.string   "phone_number"
    t.string   "bill_address_1"
    t.string   "bill_address_2"
    t.string   "bill_city"
    t.string   "bill_state"
    t.integer  "bill_zip"
    t.datetime "created_at"
    t.datetime "updated_at"
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
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

end
