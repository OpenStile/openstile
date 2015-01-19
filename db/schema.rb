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

ActiveRecord::Schema.define(version: 20150119130158) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "body_shapes", force: true do |t|
    t.string   "name"
    t.string   "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "bottom_sizes", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "category"
  end

  create_table "bottom_sizes_bottoms", id: false, force: true do |t|
    t.integer "bottom_id",      null: false
    t.integer "bottom_size_id", null: false
  end

  add_index "bottom_sizes_bottoms", ["bottom_id", "bottom_size_id"], name: "sizes_for_a_bottom_index", using: :btree
  add_index "bottom_sizes_bottoms", ["bottom_size_id", "bottom_id"], name: "bottoms_of_a_size_index", using: :btree

  create_table "bottom_sizes_retailers", id: false, force: true do |t|
    t.integer "retailer_id",    null: false
    t.integer "bottom_size_id", null: false
  end

  add_index "bottom_sizes_retailers", ["bottom_size_id", "retailer_id"], name: "retailers_for_a_bottom_size_index", using: :btree
  add_index "bottom_sizes_retailers", ["retailer_id", "bottom_size_id"], name: "retailer_bottom_sizes_index", using: :btree

  create_table "bottom_sizes_style_profiles", id: false, force: true do |t|
    t.integer "style_profile_id", null: false
    t.integer "bottom_size_id",   null: false
  end

  add_index "bottom_sizes_style_profiles", ["bottom_size_id", "style_profile_id"], name: "shoppers_for_a_bottom_size_index", using: :btree
  add_index "bottom_sizes_style_profiles", ["style_profile_id", "bottom_size_id"], name: "shopper_bottom_sizes_index", using: :btree

  create_table "bottoms", force: true do |t|
    t.string   "name"
    t.string   "description"
    t.string   "web_link"
    t.decimal  "price"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "retailer_id"
    t.integer  "look_id"
    t.integer  "color_id"
    t.integer  "print_id"
    t.integer  "body_shape_id"
  end

  add_index "bottoms", ["body_shape_id"], name: "index_bottoms_on_body_shape_id", using: :btree
  add_index "bottoms", ["color_id"], name: "index_bottoms_on_color_id", using: :btree
  add_index "bottoms", ["look_id"], name: "index_bottoms_on_look_id", using: :btree
  add_index "bottoms", ["print_id"], name: "index_bottoms_on_print_id", using: :btree
  add_index "bottoms", ["retailer_id"], name: "index_bottoms_on_retailer_id", using: :btree

  create_table "budgets", force: true do |t|
    t.integer  "style_profile_id"
    t.decimal  "top_min_price"
    t.decimal  "top_max_price"
    t.decimal  "bottom_min_price"
    t.decimal  "bottom_max_price"
    t.decimal  "dress_min_price"
    t.decimal  "dress_max_price"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "budgets", ["style_profile_id"], name: "index_budgets_on_style_profile_id", using: :btree

  create_table "colors", force: true do |t|
    t.string   "name"
    t.string   "hexcode"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "dress_sizes", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "category"
  end

  create_table "dress_sizes_dresses", id: false, force: true do |t|
    t.integer "dress_id",      null: false
    t.integer "dress_size_id", null: false
  end

  add_index "dress_sizes_dresses", ["dress_id", "dress_size_id"], name: "sizes_for_a_dress_index", using: :btree
  add_index "dress_sizes_dresses", ["dress_size_id", "dress_id"], name: "dresses_of_a_size_index", using: :btree

  create_table "dress_sizes_retailers", id: false, force: true do |t|
    t.integer "retailer_id",   null: false
    t.integer "dress_size_id", null: false
  end

  add_index "dress_sizes_retailers", ["dress_size_id", "retailer_id"], name: "retailers_for_a_dress_size_index", using: :btree
  add_index "dress_sizes_retailers", ["retailer_id", "dress_size_id"], name: "retailer_dress_sizes_index", using: :btree

  create_table "dress_sizes_style_profiles", id: false, force: true do |t|
    t.integer "style_profile_id", null: false
    t.integer "dress_size_id",    null: false
  end

  add_index "dress_sizes_style_profiles", ["dress_size_id", "style_profile_id"], name: "shoppers_for_a_dress_size_index", using: :btree
  add_index "dress_sizes_style_profiles", ["style_profile_id", "dress_size_id"], name: "shopper_dress_sizes_index", using: :btree

  create_table "dresses", force: true do |t|
    t.string   "name"
    t.string   "description"
    t.string   "web_link"
    t.decimal  "price"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "retailer_id"
    t.integer  "look_id"
    t.integer  "color_id"
    t.integer  "print_id"
    t.integer  "body_shape_id"
  end

  add_index "dresses", ["body_shape_id"], name: "index_dresses_on_body_shape_id", using: :btree
  add_index "dresses", ["color_id"], name: "index_dresses_on_color_id", using: :btree
  add_index "dresses", ["look_id"], name: "index_dresses_on_look_id", using: :btree
  add_index "dresses", ["print_id"], name: "index_dresses_on_print_id", using: :btree
  add_index "dresses", ["retailer_id"], name: "index_dresses_on_retailer_id", using: :btree

  create_table "exposed_parts", force: true do |t|
    t.integer  "part_id"
    t.integer  "exposable_id"
    t.string   "exposable_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "exposed_parts", ["exposable_id", "exposable_type"], name: "index_exposed_parts_on_exposable_id_and_exposable_type", using: :btree
  add_index "exposed_parts", ["part_id"], name: "index_exposed_parts_on_part_id", using: :btree

  create_table "hated_colors", force: true do |t|
    t.integer  "style_profile_id"
    t.integer  "color_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "hated_colors", ["color_id"], name: "index_hated_colors_on_color_id", using: :btree
  add_index "hated_colors", ["style_profile_id"], name: "index_hated_colors_on_style_profile_id", using: :btree

  create_table "look_tolerances", force: true do |t|
    t.integer  "style_profile_id"
    t.integer  "look_id"
    t.integer  "tolerance"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "look_tolerances", ["look_id"], name: "index_look_tolerances_on_look_id", using: :btree
  add_index "look_tolerances", ["style_profile_id"], name: "index_look_tolerances_on_style_profile_id", using: :btree

  create_table "looks", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "part_exposure_tolerances", force: true do |t|
    t.integer  "part_id"
    t.integer  "style_profile_id"
    t.integer  "tolerance"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "part_exposure_tolerances", ["part_id"], name: "index_part_exposure_tolerances_on_part_id", using: :btree
  add_index "part_exposure_tolerances", ["style_profile_id"], name: "index_part_exposure_tolerances_on_style_profile_id", using: :btree

  create_table "parts", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "price_ranges", force: true do |t|
    t.integer  "retailer_id"
    t.decimal  "top_min_price"
    t.decimal  "top_max_price"
    t.decimal  "bottom_min_price"
    t.decimal  "bottom_max_price"
    t.decimal  "dress_min_price"
    t.decimal  "dress_max_price"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "price_ranges", ["retailer_id"], name: "index_price_ranges_on_retailer_id", using: :btree

  create_table "print_tolerances", force: true do |t|
    t.integer  "style_profile_id"
    t.integer  "print_id"
    t.integer  "tolerance"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "print_tolerances", ["print_id"], name: "index_print_tolerances_on_print_id", using: :btree
  add_index "print_tolerances", ["style_profile_id"], name: "index_print_tolerances_on_style_profile_id", using: :btree

  create_table "prints", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "retailers", force: true do |t|
    t.string   "name"
    t.string   "description"
    t.string   "neighborhood"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "look_id"
    t.integer  "body_shape_id"
    t.boolean  "for_petite"
    t.boolean  "for_tall"
    t.boolean  "for_full_figured"
    t.string   "top_fit"
    t.string   "bottom_fit"
  end

  add_index "retailers", ["body_shape_id"], name: "index_retailers_on_body_shape_id", using: :btree
  add_index "retailers", ["look_id"], name: "index_retailers_on_look_id", using: :btree

  create_table "retailers_special_considerations", id: false, force: true do |t|
    t.integer "retailer_id",              null: false
    t.integer "special_consideration_id", null: false
  end

  add_index "retailers_special_considerations", ["retailer_id", "special_consideration_id"], name: "special_considerations_for_a_retailer_index", using: :btree
  add_index "retailers_special_considerations", ["special_consideration_id", "retailer_id"], name: "retailers_for_a_special_consideration_index", using: :btree

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

  create_table "special_considerations", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "special_considerations_style_profiles", id: false, force: true do |t|
    t.integer "special_consideration_id", null: false
    t.integer "style_profile_id",         null: false
  end

  add_index "special_considerations_style_profiles", ["special_consideration_id", "style_profile_id"], name: "style_profiles_for_a_special_consideration_index", using: :btree
  add_index "special_considerations_style_profiles", ["style_profile_id", "special_consideration_id"], name: "special_consideration_for_style_profile_index", using: :btree

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
    t.integer  "body_shape_id"
    t.integer  "height_feet"
    t.integer  "height_inches"
    t.string   "body_build"
    t.string   "top_fit"
    t.string   "bottom_fit"
  end

  add_index "style_profiles", ["body_shape_id"], name: "index_style_profiles_on_body_shape_id", using: :btree
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

  create_table "top_sizes_tops", id: false, force: true do |t|
    t.integer "top_id",      null: false
    t.integer "top_size_id", null: false
  end

  add_index "top_sizes_tops", ["top_id", "top_size_id"], name: "sizes_for_a_top_index", using: :btree
  add_index "top_sizes_tops", ["top_size_id", "top_id"], name: "tops_of_a_size_index", using: :btree

  create_table "tops", force: true do |t|
    t.string   "name"
    t.string   "description"
    t.string   "web_link"
    t.decimal  "price"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "retailer_id"
    t.integer  "look_id"
    t.integer  "color_id"
    t.integer  "print_id"
    t.integer  "body_shape_id"
  end

  add_index "tops", ["body_shape_id"], name: "index_tops_on_body_shape_id", using: :btree
  add_index "tops", ["color_id"], name: "index_tops_on_color_id", using: :btree
  add_index "tops", ["look_id"], name: "index_tops_on_look_id", using: :btree
  add_index "tops", ["print_id"], name: "index_tops_on_print_id", using: :btree
  add_index "tops", ["retailer_id"], name: "index_tops_on_retailer_id", using: :btree

end
