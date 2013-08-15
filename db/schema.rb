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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20130815203549) do

  create_table "backend_users", :force => true do |t|
    t.string   "email"
    t.string   "salt"
    t.string   "encrypted_password"
    t.boolean  "admin"
    t.boolean  "staff"
    t.boolean  "developer"
    t.boolean  "partner"
    t.string   "firstname"
    t.string   "surname"
    t.string   "login"
    t.boolean  "deleted"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "fundamental_character_positions", :force => true do |t|
    t.integer  "geo_character_id"
    t.decimal  "longitude"
    t.decimal  "latitude"
    t.integer  "delta",            :default => 0,     :null => false
    t.boolean  "suspect",          :default => false, :null => false
    t.string   "remote_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "fundamental_characters", :force => true do |t|
    t.integer  "character_id"
    t.string   "identifier"
    t.boolean  "deleted",                :default => false, :null => false
    t.decimal  "longitude"
    t.decimal  "latitude"
    t.datetime "location_updated_at"
    t.decimal  "distance_today",         :default => 0.0,   :null => false
    t.decimal  "distance_total",         :default => 0.0,   :null => false
    t.datetime "premium_ended_at"
    t.decimal  "longitude_bias",         :default => 0.0,   :null => false
    t.decimal  "latitude_bias",          :default => 0.0,   :null => false
    t.boolean  "bias_enabled",           :default => true,  :null => false
    t.integer  "privacy_mode",           :default => 5,     :null => false
    t.boolean  "geo_enabled",            :default => true,  :null => false
    t.datetime "geo_setting_changed_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "fundamental_daily_position_stats", :force => true do |t|
    t.integer  "geo_character_id"
    t.decimal  "distance",         :default => 0.0,   :null => false
    t.integer  "reports",          :default => 0,     :null => false
    t.integer  "max_vel",          :default => 0,     :null => false
    t.boolean  "geo_enabled"
    t.boolean  "suspect",          :default => false, :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.date     "day"
  end

  create_table "treasure_treasure_hunts", :force => true do |t|
    t.integer  "category"
    t.integer  "level",            :default => 0,     :null => false
    t.decimal  "latitude"
    t.decimal  "longitutde"
    t.integer  "difficulty",       :default => 0,     :null => false
    t.integer  "geo_character_id"
    t.integer  "distance"
    t.boolean  "success",          :default => false, :null => false
    t.integer  "treasure_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "treasure_treasures", :force => true do |t|
    t.integer  "category"
    t.integer  "level",      :default => 0, :null => false
    t.decimal  "latitude"
    t.decimal  "longitutde"
    t.integer  "difficulty", :default => 0, :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
