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

ActiveRecord::Schema.define(version: 20150109160539) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "bottom_sizes", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "category"
  end

  create_table "bottom_sizes_style_profiles", id: false, force: true do |t|
    t.integer "style_profile_id", null: false
    t.integer "bottom_size_id",   null: false
  end

  add_index "bottom_sizes_style_profiles", ["bottom_size_id", "style_profile_id"], name: "shoppers_for_a_bottom_size_index", using: :btree
  add_index "bottom_sizes_style_profiles", ["style_profile_id", "bottom_size_id"], name: "shopper_bottom_sizes_index", using: :btree

  create_table "dress_sizes", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "category"
  end

  create_table "dress_sizes_style_profiles", id: false, force: true do |t|
    t.integer "style_profile_id", null: false
    t.integer "dress_size_id",    null: false
  end

  add_index "dress_sizes_style_profiles", ["dress_size_id", "style_profile_id"], name: "shoppers_for_a_dress_size_index", using: :btree
  add_index "dress_sizes_style_profiles", ["style_profile_id", "dress_size_id"], name: "shopper_dress_sizes_index", using: :btree

  create_table "retailers", force: true do |t|
    t.string   "name"
    t.string   "description"
    t.string   "neighborhood"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "retailers_top_sizes", id: false, force: true do |t|
    t.integer "retailer_id", null: false
    t.integer "top_size_id", null: false
  end

  add_index "retailers_top_sizes", ["retailer_id", "top_size_id"], name: "retailer_top_sizes_index", using: :btree
  add_index "retailers_top_sizes", ["top_size_id", "retailer_id"], name: "retailers_for_a_top_size_index", using: :btree

  create_table "shoppers", force: true do |t|
    t.string   "first_name"
    t.string   "email"
    t.string   "cell_phone"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email"
  end

  add_index "shoppers", ["email"], name: "index_shoppers_on_email", unique: true, using: :btree

  create_table "style_profile_top_sizes", force: true do |t|
    t.integer  "style_profile_id"
    t.integer  "top_size_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "style_profile_top_sizes", ["style_profile_id"], name: "index_style_profile_top_sizes_on_style_profile_id", using: :btree
  add_index "style_profile_top_sizes", ["top_size_id"], name: "index_style_profile_top_sizes_on_top_size_id", using: :btree

  create_table "style_profiles", force: true do |t|
    t.integer  "shopper_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "style_profiles", ["shopper_id"], name: "index_style_profiles_on_shopper_id", using: :btree

  create_table "style_profiles_top_sizes", id: false, force: true do |t|
    t.integer "style_profile_id", null: false
    t.integer "top_size_id",      null: false
  end

  add_index "style_profiles_top_sizes", ["style_profile_id", "top_size_id"], name: "shopper_top_sizes_index", using: :btree
  add_index "style_profiles_top_sizes", ["top_size_id", "style_profile_id"], name: "shoppers_for_a_top_size_index", using: :btree

  create_table "top_sizes", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "category"
  end

end
