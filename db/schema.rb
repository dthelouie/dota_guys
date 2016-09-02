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

ActiveRecord::Schema.define(version: 20160819052019) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "matches", force: :cascade do |t|
    t.string   "uid"
    t.string   "winner"
    t.string   "first_blood"
    t.datetime "started_at"
    t.string   "mode"
    t.string   "match_type"
    t.string   "duration"
    t.integer  "cluster"
    t.integer  "user_id"
  end

  create_table "players", force: :cascade do |t|
    t.integer "match_id"
    t.string  "uid"
    t.text    "hero"
    t.integer "level"
    t.integer "kills"
    t.integer "deaths"
    t.integer "assists"
    t.integer "last_hits"
    t.integer "denies"
    t.integer "gold"
    t.integer "gpm"
    t.integer "xpm"
    t.string  "status"
    t.integer "gold_spent"
    t.integer "hero_damage"
    t.integer "tower_damage"
    t.integer "hero_healing"
    t.text    "items"
    t.integer "slot"
    t.boolean "radiant"
  end

  create_table "users", force: :cascade do |t|
    t.string "uid",         null: false
    t.string "nickname",    null: false
    t.string "avatar_url",  null: false
    t.string "profile_url", null: false
  end

end
