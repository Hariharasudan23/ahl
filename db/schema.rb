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

ActiveRecord::Schema.define(version: 20170103185455) do

  create_table "friendly_id_slugs", force: :cascade do |t|
    t.string   "slug",           limit: 255, null: false
    t.integer  "sluggable_id",   limit: 4,   null: false
    t.string   "sluggable_type", limit: 50
    t.string   "scope",          limit: 255
    t.datetime "created_at"
  end

  add_index "friendly_id_slugs", ["slug", "sluggable_type", "scope"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type_and_scope", unique: true, using: :btree
  add_index "friendly_id_slugs", ["slug", "sluggable_type"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type", using: :btree
  add_index "friendly_id_slugs", ["sluggable_id"], name: "index_friendly_id_slugs_on_sluggable_id", using: :btree
  add_index "friendly_id_slugs", ["sluggable_type"], name: "index_friendly_id_slugs_on_sluggable_type", using: :btree

  create_table "goals", force: :cascade do |t|
    t.integer  "match_id",    limit: 4
    t.integer  "player_id",   limit: 4
    t.integer  "opponent_id", limit: 4
    t.datetime "created_at",            null: false
    t.datetime "updated_at",            null: false
  end

  create_table "live_scores", force: :cascade do |t|
    t.integer  "teamone_goals", limit: 4
    t.integer  "teamtwo_goals", limit: 4
    t.text     "commentary",    limit: 65535
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
    t.integer  "match_id",      limit: 4
  end

  create_table "matches", force: :cascade do |t|
    t.integer  "team1_id",         limit: 4
    t.integer  "team2_id",         limit: 4
    t.integer  "result",           limit: 4,   default: -2
    t.datetime "created_at",                                   null: false
    t.datetime "updated_at",                                   null: false
    t.integer  "man_of_the_match", limit: 4
    t.integer  "trump_card",       limit: 4
    t.boolean  "running",          limit: 1,   default: false
    t.string   "slug",             limit: 255
    t.datetime "time"
  end

  add_index "matches", ["slug"], name: "index_matches_on_slug", unique: true, using: :btree

  create_table "photos", force: :cascade do |t|
    t.integer  "match_id",   limit: 4
    t.string   "photo_url",  limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "players", force: :cascade do |t|
    t.string   "name",         limit: 255
    t.integer  "age",          limit: 4
    t.string   "position",     limit: 255
    t.datetime "created_at",                           null: false
    t.datetime "updated_at",                           null: false
    t.integer  "team_id",      limit: 4
    t.integer  "green_cards",  limit: 4,   default: 0
    t.integer  "yellow_cards", limit: 4,   default: 0
    t.integer  "red_cards",    limit: 4,   default: 0
    t.string   "photo",        limit: 255
    t.integer  "goals_count",  limit: 4,   default: 0
    t.string   "gender",       limit: 255
  end

  create_table "reports", force: :cascade do |t|
    t.text     "article",    limit: 65535
    t.string   "image",      limit: 255
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
    t.text     "caption",    limit: 65535
    t.string   "slug",       limit: 255
    t.integer  "match_id",   limit: 4
  end

  add_index "reports", ["slug"], name: "index_reports_on_slug", unique: true, using: :btree

  create_table "teams", force: :cascade do |t|
    t.string   "name",        limit: 255
    t.string   "motto",       limit: 255
    t.integer  "points",      limit: 4,     default: -2
    t.datetime "created_at",                              null: false
    t.datetime "updated_at",                              null: false
    t.string   "slug",        limit: 255
    t.integer  "captain",     limit: 4
    t.string   "color",       limit: 255
    t.string   "logo",        limit: 255
    t.text     "description", limit: 65535
    t.string   "gender",      limit: 1,     default: "m"
  end

  add_index "teams", ["slug"], name: "index_teams_on_slug", unique: true, using: :btree

end
