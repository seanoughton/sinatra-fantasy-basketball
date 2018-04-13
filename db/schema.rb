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

ActiveRecord::Schema.define(version: 2018_04_11_175841) do

  create_table "players", force: :cascade do |t|
    t.integer "rank"
    t.string "playername"
    t.string "position"
    t.integer "age"
    t.string "originalteam"
    t.float "fg_perc"
    t.float "three_pt_perc"
    t.float "two_pt_perc"
    t.float "free_throw_perc"
    t.float "oreb"
    t.float "reb"
    t.float "assists"
    t.float "steals"
    t.float "blocks"
    t.float "turnovers"
    t.float "ps_per_game"
    t.integer "team_id"
  end

  create_table "teams", force: :cascade do |t|
    t.string "teamname"
    t.integer "user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "username"
    t.string "email"
    t.string "password_digest"
  end

end
