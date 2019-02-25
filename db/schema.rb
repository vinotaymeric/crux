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

ActiveRecord::Schema.define(version: 2019_02_25_163058) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "activities", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "basecamps", force: :cascade do |t|
    t.string "name"
    t.string "location"
    t.float "coord_long"
    t.float "coord_lat"
    t.bigint "activity_id"
    t.bigint "trip_id"
    t.bigint "itinerary_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["activity_id"], name: "index_basecamps_on_activity_id"
    t.index ["itinerary_id"], name: "index_basecamps_on_itinerary_id"
    t.index ["trip_id"], name: "index_basecamps_on_trip_id"
  end

  create_table "basecamps_itienraries", force: :cascade do |t|
    t.bigint "itinerary_id"
    t.bigint "basecamp_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["basecamp_id"], name: "index_basecamps_itienraries_on_basecamp_id"
    t.index ["itinerary_id"], name: "index_basecamps_itienraries_on_itinerary_id"
  end

  create_table "itineraries", force: :cascade do |t|
    t.string "name"
    t.text "content"
    t.string "coord_x"
    t.string "coord_y"
    t.string "difficulty"
    t.integer "elevation_max"
    t.integer "height_diff_up"
    t.string "engagement_rating"
    t.string "equipment_rating"
    t.string "orientations"
    t.integer "number_of_outing"
    t.string "picture_url"
    t.float "coord_long"
    t.float "coord_lat"
    t.bigint "activity_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["activity_id"], name: "index_itineraries_on_activity_id"
  end

  create_table "trips", force: :cascade do |t|
    t.string "title"
    t.date "start_date"
    t.date "end_date"
    t.bigint "user_id"
    t.string "favorite_activity"
    t.string "location"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_trips_on_user_id"
  end

  create_table "trips_basecamps", force: :cascade do |t|
    t.bigint "trip_id"
    t.bigint "basecamp_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["basecamp_id"], name: "index_trips_basecamps_on_basecamp_id"
    t.index ["trip_id"], name: "index_trips_basecamps_on_trip_id"
  end

  create_table "user_activities", force: :cascade do |t|
    t.string "level"
    t.bigint "user_id"
    t.bigint "activity_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["activity_id"], name: "index_user_activities_on_activity_id"
    t.index ["user_id"], name: "index_user_activities_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "basecamps", "activities"
  add_foreign_key "basecamps", "itineraries"
  add_foreign_key "basecamps", "trips"
  add_foreign_key "basecamps_itienraries", "basecamps"
  add_foreign_key "basecamps_itienraries", "itineraries"
  add_foreign_key "itineraries", "activities"
  add_foreign_key "trips", "users"
  add_foreign_key "trips_basecamps", "basecamps"
  add_foreign_key "trips_basecamps", "trips"
  add_foreign_key "user_activities", "activities"
  add_foreign_key "user_activities", "users"
end
