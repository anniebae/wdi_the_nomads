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

ActiveRecord::Schema.define(version: 20141121015204) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "trails", force: true do |t|
    t.string   "geocoordinates"
    t.string   "url"
    t.string   "park"
    t.string   "title"
    t.string   "region"
    t.string   "state"
    t.string   "length"
    t.string   "difficulty"
    t.string   "dogs"
    t.string   "lat"
    t.string   "lon"
    t.text     "features"
    t.integer  "drivingfromgrandcentralmiles"
    t.integer  "drivingfromgrandcentralseconds"
    t.integer  "cyclingfromgrandcentralmiles"
    t.integer  "cyclingfromgrandcentralseconds"
    t.integer  "walkingfromgrandcentralmiles"
    t.integer  "walkingfromgrandcentralseconds"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "trailsolutions", force: true do |t|
    t.string   "length"
    t.string   "difficulty"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "park"
    t.string   "title"
    t.string   "region"
    t.string   "state"
    t.string   "dogs"
    t.string   "lat"
    t.string   "lon"
    t.text     "features"
    t.string   "url"
  end

end