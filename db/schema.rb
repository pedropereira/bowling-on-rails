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

ActiveRecord::Schema.define(:version => 20120721111557) do

  create_table "frames", :force => true do |t|
    t.integer  "first_roll"
    t.integer  "second_roll"
    t.integer  "third_roll"
    t.integer  "pins_left",   :default => 10
    t.integer  "score",       :default => 0
    t.string   "mark",        :default => "open"
    t.integer  "game_id"
    t.datetime "created_at",                      :null => false
    t.datetime "updated_at",                      :null => false
  end

  add_index "frames", ["game_id"], :name => "index_frames_on_game_id"

  create_table "games", :force => true do |t|
    t.integer  "current_frame_number", :default => 1
    t.datetime "created_at",                              :null => false
    t.datetime "updated_at",                              :null => false
    t.boolean  "finished",             :default => false
  end

end
