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

ActiveRecord::Schema.define(version: 20140812151021) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "event_occurrences", force: true do |t|
    t.integer  "event_id"
    t.datetime "start_datetime"
    t.string   "state"
    t.integer  "aforo"
    t.integer  "num_confirm"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "events", force: true do |t|
    t.text     "recurring_rule"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.datetime "start_date"
    t.string   "name"
    t.integer  "aforo"
    t.string   "state",          default: "active"
    t.integer  "first_call"
    t.integer  "last_call"
    t.integer  "call_hour"
  end

  create_table "notifications", force: true do |t|
    t.integer  "event_id"
    t.integer  "event_occurrence_id"
    t.integer  "user_id"
    t.string   "state"
    t.text     "comment"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.datetime "start_datetime"
    t.datetime "end_datetime"
    t.datetime "last_shipping"
    t.datetime "rush_start"
  end

  create_table "user_events", force: true do |t|
    t.integer  "user_id"
    t.integer  "event_id"
    t.string   "state"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", force: true do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "first_name"
    t.string   "last_name"
    t.integer  "notif_hour"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

end
