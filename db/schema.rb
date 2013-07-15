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

ActiveRecord::Schema.define(version: 20130713234009) do

  create_table "dishes", force: true do |t|
    t.string   "name"
    t.text     "instructions"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "ingredients", force: true do |t|
    t.string   "amount"
    t.string   "unit"
    t.string   "description"
    t.integer  "dish_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "meals", force: true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "prep_time"
    t.string   "cook_time"
    t.string   "total_time"
    t.string   "flags",      default: [], array: true
    t.integer  "entree_id"
    t.integer  "side_id"
    t.integer  "rating",     default: 0
  end

end
