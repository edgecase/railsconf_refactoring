# This file is auto-generated from the current state of the database. Instead of editing this file, 
# please use the migrations feature of Active Record to incrementally modify your database, and
# then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your database schema. If you need
# to create the application database on another system, you should be using db:schema:load, not running
# all the migrations from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20090428151959) do

  create_table "computer_players", :force => true do |t|
    t.string   "strategy"
    t.integer  "score",      :default => 0
    t.integer  "game_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "games", :force => true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "human_players", :force => true do |t|
    t.string   "name"
    t.integer  "score"
    t.integer  "game_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "turns", :force => true do |t|
    t.integer  "game_id"
    t.integer  "player_id"
    t.integer  "score"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
