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

ActiveRecord::Schema.define(version: 2019_04_24_170719) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "activities", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "areas", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.float "coord_long"
    t.float "coord_lat"
    t.bigint "city_id"
    t.index ["city_id"], name: "index_areas_on_city_id"
  end

  create_table "basecamps", force: :cascade do |t|
    t.string "name"
    t.float "coord_long"
    t.float "coord_lat"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "mountain_range_id"
    t.integer "source_id"
    t.bigint "area_id"
    t.index ["area_id"], name: "index_basecamps_on_area_id"
    t.index ["mountain_range_id"], name: "index_basecamps_on_mountain_range_id"
  end

  create_table "cities", force: :cascade do |t|
    t.string "name"
    t.float "coord_long"
    t.float "coord_lat"
    t.string "city_inhab"
    t.string "code_insee"
    t.string "geoname"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "mountain_range_id"
    t.float "temp_score"
    t.string "temp_activity"
    t.bigint "weather_id"
    t.index ["mountain_range_id"], name: "index_cities_on_mountain_range_id"
    t.index ["weather_id"], name: "index_cities_on_weather_id"
  end

  create_table "favorite_itineraries", force: :cascade do |t|
    t.bigint "trip_id"
    t.bigint "itinerary_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["itinerary_id"], name: "index_favorite_itineraries_on_itinerary_id"
    t.index ["trip_id"], name: "index_favorite_itineraries_on_trip_id"
  end

  create_table "follows", force: :cascade do |t|
    t.bigint "itinerary_id"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["itinerary_id"], name: "index_follows_on_itinerary_id"
    t.index ["user_id"], name: "index_follows_on_user_id"
  end

  create_table "huts", force: :cascade do |t|
    t.float "coord_long"
    t.float "coord_lat"
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "source_id"
  end

  create_table "invitations", force: :cascade do |t|
    t.bigint "trip_id"
    t.string "mailed_to"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "token"
    t.index ["trip_id"], name: "index_invitations_on_trip_id"
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
    t.string "level"
    t.integer "source_id"
    t.bigint "basecamp_id"
    t.bigint "hut_id"
    t.string "height_diff_down"
    t.string "ski_rating"
    t.string "hiking_rating"
    t.float "score"
    t.string "universal_difficulty"
    t.string "slug"
    t.index ["activity_id"], name: "index_itineraries_on_activity_id"
    t.index ["basecamp_id"], name: "index_itineraries_on_basecamp_id"
    t.index ["hut_id"], name: "index_itineraries_on_hut_id"
  end

  create_table "messages", force: :cascade do |t|
    t.bigint "trip_id"
    t.bigint "user_id"
    t.string "content"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["trip_id"], name: "index_messages_on_trip_id"
    t.index ["user_id"], name: "index_messages_on_user_id"
  end

  create_table "mountain_ranges", force: :cascade do |t|
    t.string "name"
    t.string "rosace_url"
    t.string "fresh_snow_url"
    t.string "snow_image_url"
    t.string "snow_quality"
    t.string "stability"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.float "coord_lat"
    t.float "coord_long"
    t.date "bra_date"
    t.integer "max_risk"
  end

  create_table "outings", force: :cascade do |t|
    t.bigint "itinerary_id"
    t.string "date"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "source_id"
    t.text "content"
    t.index ["itinerary_id"], name: "index_outings_on_itinerary_id"
  end

  create_table "participants", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "trip_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["trip_id"], name: "index_participants_on_trip_id"
    t.index ["user_id"], name: "index_participants_on_user_id"
  end

  create_table "requests", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "trip_id"
    t.index ["trip_id"], name: "index_requests_on_trip_id"
  end

  create_table "trip_activities", force: :cascade do |t|
    t.bigint "trip_id"
    t.bigint "activity_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "level"
    t.index ["activity_id"], name: "index_trip_activities_on_activity_id"
    t.index ["trip_id"], name: "index_trip_activities_on_trip_id"
  end

  create_table "trips", force: :cascade do |t|
    t.string "title"
    t.date "start_date"
    t.date "end_date"
    t.bigint "user_id"
    t.string "location"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.float "coord_lat"
    t.float "coord_long"
    t.boolean "validated"
    t.bigint "city_id"
    t.bigint "trip_activity_id"
    t.index ["city_id"], name: "index_trips_on_city_id"
    t.index ["trip_activity_id"], name: "index_trips_on_trip_activity_id"
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
    t.string "username"
    t.boolean "guest", default: false
    t.string "phone"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  create_table "weathers", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.json "forecast"
  end

  add_foreign_key "areas", "cities"
  add_foreign_key "basecamps", "areas"
  add_foreign_key "basecamps", "mountain_ranges"
  add_foreign_key "cities", "mountain_ranges"
  add_foreign_key "cities", "weathers"
  add_foreign_key "favorite_itineraries", "itineraries"
  add_foreign_key "favorite_itineraries", "trips"
  add_foreign_key "follows", "itineraries"
  add_foreign_key "follows", "users"
  add_foreign_key "invitations", "trips"
  add_foreign_key "itineraries", "activities"
  add_foreign_key "itineraries", "basecamps"
  add_foreign_key "itineraries", "huts"
  add_foreign_key "messages", "trips"
  add_foreign_key "messages", "users"
  add_foreign_key "outings", "itineraries"
  add_foreign_key "participants", "trips"
  add_foreign_key "participants", "users"
  add_foreign_key "requests", "trips"
  add_foreign_key "trip_activities", "activities"
  add_foreign_key "trip_activities", "trips"
  add_foreign_key "trips", "cities"
  add_foreign_key "trips", "trip_activities"
  add_foreign_key "trips", "users"
  add_foreign_key "trips_basecamps", "basecamps"
  add_foreign_key "trips_basecamps", "trips"
  add_foreign_key "user_activities", "activities"
  add_foreign_key "user_activities", "users"
end
