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

ActiveRecord::Schema.define(version: 20140605060313) do

  create_table "addresses", force: true do |t|
    t.integer  "user_id"
    t.string   "recipient"
    t.string   "rep_address_one"
    t.string   "city"
    t.string   "state"
    t.string   "zipcode"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "client"
    t.string   "phone"
    t.string   "rep_address_two"
  end

  create_table "contacts", force: true do |t|
    t.string   "email"
    t.string   "name"
    t.string   "subject"
    t.text     "query"
    t.string   "signature_file_name"
    t.string   "signature_content_type"
    t.integer  "signature_file_size"
    t.datetime "signature_updated_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "homes", force: true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.time     "cut_off_time"
    t.integer  "user_id"
    t.integer  "admin_id"
  end

  create_table "shipments", force: true do |t|
    t.string   "tmx"
    t.string   "signature_status"
    t.string   "refrence"
    t.integer  "number_of_packages"
    t.boolean  "notification"
    t.integer  "tracking"
    t.date     "ship_date"
    t.date     "expected_delivery_date"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
    t.boolean  "save_to_book"
    t.text     "instructions"
    t.string   "status",                 default: "Awating Pickup"
    t.integer  "client"
    t.integer  "cod_val"
    t.integer  "declared_val"
    t.date     "pickup_at"
    t.date     "deliver_at"
    t.date     "picked_up_at"
    t.date     "delivered_at"
    t.integer  "to_customer"
    t.integer  "from_customer"
    t.string   "from_address"
    t.string   "to_address"
    t.string   "user_name_print"
    t.string   "signature_file_name"
    t.string   "signature_content_type"
    t.integer  "signature_file_size"
    t.datetime "signature_updated_at"
  end

  add_index "shipments", ["user_id"], name: "index_shipments_on_user_id", using: :btree

  create_table "users", force: true do |t|
    t.string   "email",                  default: "",    null: false
    t.string   "encrypted_password",     default: "",    null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,     null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "company_name"
    t.string   "usr_address"
    t.string   "city"
    t.string   "state"
    t.integer  "zipcode"
    t.string   "service_type"
    t.string   "phone"
    t.string   "fax"
    t.string   "account_number"
    t.string   "encrypted"
    t.string   "first_name"
    t.string   "last_name"
    t.boolean  "is_admin",               default: false
    t.boolean  "terms_of_use"
    t.boolean  "is_active",              default: true
    t.boolean  "sudo_flag",              default: false
    t.string   "usr_note"
    t.boolean  "acc_ready_mail",         default: false
    t.boolean  "is_superadmin",          default: false
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

end
