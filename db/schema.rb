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

ActiveRecord::Schema.define(version: 20150911212027) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "admins", force: true do |t|
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

  add_index "admins", ["email"], name: "index_admins_on_email", unique: true, using: :btree
  add_index "admins", ["reset_password_token"], name: "index_admins_on_reset_password_token", unique: true, using: :btree

  create_table "body_builds", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "body_builds_style_profiles", id: false, force: true do |t|
    t.integer "body_build_id",    null: false
    t.integer "style_profile_id", null: false
  end

  add_index "body_builds_style_profiles", ["body_build_id", "style_profile_id"], name: "index_profiles_for_a_body_build", using: :btree
  add_index "body_builds_style_profiles", ["style_profile_id", "body_build_id"], name: "index_builds_for_a_profile", using: :btree

  create_table "body_shapes", force: true do |t|
    t.string   "name"
    t.string   "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "bottom_fits", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "bottom_sizes", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "category"
  end

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

  create_table "colors", force: true do |t|
    t.string   "name"
    t.string   "hexcode"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "colors_to_avoids", force: true do |t|
    t.integer "color_id"
    t.integer "style_profile_id"
  end

  add_index "colors_to_avoids", ["color_id"], name: "index_colors_to_avoids_on_color_id", using: :btree
  add_index "colors_to_avoids", ["style_profile_id"], name: "index_colors_to_avoids_on_style_profile_id", using: :btree

  create_table "dress_sizes", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "category"
  end

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

  create_table "drop_in_availabilities", force: true do |t|
    t.integer  "retailer_id"
    t.time     "start_time"
    t.time     "end_time"
    t.integer  "bandwidth"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "location_id"
    t.string   "frequency"
    t.date     "template_date"
  end

  add_index "drop_in_availabilities", ["location_id"], name: "index_drop_in_availabilities_on_location_id", using: :btree
  add_index "drop_in_availabilities", ["retailer_id"], name: "index_drop_in_availabilities_on_retailer_id", using: :btree

  create_table "drop_ins", force: true do |t|
    t.integer  "retailer_id"
    t.integer  "shopper_id"
    t.datetime "time"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "comment"
    t.integer  "shopper_rating"
    t.integer  "retailer_rating"
    t.string   "shopper_feedback"
    t.string   "retailer_feedback"
    t.decimal  "sales_generated"
  end

  add_index "drop_ins", ["retailer_id"], name: "index_drop_ins_on_retailer_id", using: :btree
  add_index "drop_ins", ["shopper_id", "time"], name: "index_drop_ins_on_shopper_id_and_time", unique: true, using: :btree
  add_index "drop_ins", ["shopper_id"], name: "index_drop_ins_on_shopper_id", using: :btree

  create_table "locations", force: true do |t|
    t.string   "address"
    t.string   "short_title"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "neighborhood"
  end

  create_table "looks", force: true do |t|
    t.string   "name"
    t.string   "image_path"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "looks_style_profiles", id: false, force: true do |t|
    t.integer "look_id",          null: false
    t.integer "style_profile_id", null: false
  end

  add_index "looks_style_profiles", ["look_id", "style_profile_id"], name: "index_looks_style_profiles_on_look_id_and_style_profile_id", using: :btree
  add_index "looks_style_profiles", ["style_profile_id", "look_id"], name: "index_looks_style_profiles_on_style_profile_id_and_look_id", using: :btree

  create_table "online_presences", force: true do |t|
    t.integer  "retailer_id"
    t.string   "web_link"
    t.string   "facebook_link"
    t.string   "twitter_link"
    t.string   "instagram_link"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "online_presences", ["retailer_id"], name: "index_online_presences_on_retailer_id", using: :btree

  create_table "parts", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "parts_to_covers", force: true do |t|
    t.integer "part_id"
    t.integer "style_profile_id"
  end

  add_index "parts_to_covers", ["part_id"], name: "index_parts_to_covers_on_part_id", using: :btree
  add_index "parts_to_covers", ["style_profile_id"], name: "index_parts_to_covers_on_style_profile_id", using: :btree

  create_table "parts_to_flaunts", force: true do |t|
    t.integer "part_id"
    t.integer "style_profile_id"
  end

  add_index "parts_to_flaunts", ["part_id"], name: "index_parts_to_flaunts_on_part_id", using: :btree
  add_index "parts_to_flaunts", ["style_profile_id"], name: "index_parts_to_flaunts_on_style_profile_id", using: :btree

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

  create_table "retail_users", force: true do |t|
    t.string   "email"
    t.string   "cell_phone"
    t.integer  "retailer_id"
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

  create_table "retailers", force: true do |t|
    t.string   "name"
    t.string   "description"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "look_id"
    t.integer  "body_shape_id"
    t.boolean  "for_petite"
    t.boolean  "for_tall"
    t.boolean  "for_full_figured"
    t.integer  "location_id"
    t.integer  "top_fit_id"
    t.integer  "bottom_fit_id"
    t.integer  "status"
  end

  add_index "retailers", ["body_shape_id"], name: "index_retailers_on_body_shape_id", using: :btree
  add_index "retailers", ["bottom_fit_id"], name: "index_retailers_on_bottom_fit_id", using: :btree
  add_index "retailers", ["location_id"], name: "index_retailers_on_location_id", using: :btree
  add_index "retailers", ["look_id"], name: "index_retailers_on_look_id", using: :btree
  add_index "retailers", ["top_fit_id"], name: "index_retailers_on_top_fit_id", using: :btree

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

  create_table "style_profiles", force: true do |t|
    t.integer  "shopper_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "body_shape_id"
    t.integer  "top_fit_id"
    t.integer  "bottom_fit_id"
    t.string   "top_budget"
    t.string   "bottom_budget"
    t.string   "dress_budget"
  end

  add_index "style_profiles", ["body_shape_id"], name: "index_style_profiles_on_body_shape_id", using: :btree
  add_index "style_profiles", ["bottom_fit_id"], name: "index_style_profiles_on_bottom_fit_id", using: :btree
  add_index "style_profiles", ["shopper_id"], name: "index_style_profiles_on_shopper_id", using: :btree
  add_index "style_profiles", ["top_fit_id"], name: "index_style_profiles_on_top_fit_id", using: :btree

  create_table "style_profiles_top_sizes", id: false, force: true do |t|
    t.integer "style_profile_id", null: false
    t.integer "top_size_id",      null: false
  end

  add_index "style_profiles_top_sizes", ["style_profile_id", "top_size_id"], name: "shopper_top_sizes_index", using: :btree
  add_index "style_profiles_top_sizes", ["top_size_id", "style_profile_id"], name: "shoppers_for_a_top_size_index", using: :btree

  create_table "top_fits", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "top_sizes", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "category"
  end

end
