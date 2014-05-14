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

ActiveRecord::Schema.define(version: 20140514082258) do

  create_table "events", force: true do |t|
    t.datetime "started_at"
    t.datetime "finished_at"
    t.boolean  "is_closed",   default: false
    t.boolean  "is_rated",    default: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "season_id"
  end

  add_index "events", ["season_id"], name: "index_events_on_season_id"

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

  create_table "matches", force: true do |t|
    t.date     "played_on"
    t.integer  "first_player_id"
    t.integer  "second_player_id"
    t.integer  "first_player_corporation_id"
    t.integer  "first_player_runner_id"
    t.integer  "second_player_corporation_id"
    t.integer  "second_player_runner_id"
    t.integer  "first_player_corporation_points"
    t.integer  "first_player_runner_points"
    t.integer  "second_player_corporation_points"
    t.integer  "second_player_runner_points"
    t.integer  "first_player_league_points"
    t.integer  "second_player_league_points"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "event_id"
  end

  add_index "matches", ["event_id"], name: "index_matches_on_event_id"
  add_index "matches", ["first_player_corporation_id"], name: "index_matches_on_first_player_corporation_id"
  add_index "matches", ["first_player_id"], name: "index_matches_on_first_player_id"
  add_index "matches", ["first_player_runner_id"], name: "index_matches_on_first_player_runner_id"
  add_index "matches", ["second_player_corporation_id"], name: "index_matches_on_second_player_corporation_id"
  add_index "matches", ["second_player_id"], name: "index_matches_on_second_player_id"
  add_index "matches", ["second_player_runner_id"], name: "index_matches_on_second_player_runner_id"

  create_table "seasons", force: true do |t|
    t.string   "name"
    t.boolean  "is_active",  default: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "standings", force: true do |t|
    t.integer  "rateable_id"
    t.string   "rateable_type"
    t.integer  "user_id"
    t.decimal  "rating"
    t.decimal  "deviation"
    t.decimal  "volatility"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "standings", ["rateable_id", "rateable_type"], name: "index_standings_on_rateable_id_and_rateable_type"
  add_index "standings", ["user_id"], name: "index_standings_on_user_id"

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
    t.decimal  "volatility",             default: 0.06,   null: false
    t.string   "country",                default: "",     null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "is_judge",               default: false
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true

end
