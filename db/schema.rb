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

ActiveRecord::Schema.define(version: 20140501132327) do

  create_table "events", force: true do |t|
    t.datetime "started"
    t.datetime "finished"
    t.boolean  "is_closed",  default: false
    t.boolean  "is_rated",   default: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "factions", force: true do |t|
    t.string   "name"
    t.boolean  "is_runner",      default: false
    t.boolean  "is_corporation", default: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "identities", force: true do |t|
    t.string   "name"
    t.integer  "faction_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "identities", ["faction_id"], name: "index_identities_on_faction_id"

  create_table "seasons", force: true do |t|
    t.string   "name"
    t.boolean  "is_active",  default: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", force: true do |t|
    t.string   "fullname",               default: "",     null: false
    t.string   "email",                  default: "",     null: false
    t.string   "encrypted_password",     default: "",     null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,      null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.integer  "number_of_games",        default: 0,      null: false
    t.decimal  "rating",                 default: 1500.0, null: false
    t.decimal  "deviation",              default: 350.0,  null: false
    t.decimal  "volatality",             default: 0.06,   null: false
    t.string   "country",                default: "",     null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true

end
