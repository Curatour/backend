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

ActiveRecord::Schema.define(version: 2021_04_10_211431) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "event_venues", force: :cascade do |t|
    t.bigint "event_id"
    t.bigint "venue_id"
    t.string "contact_name"
    t.string "contact_phone"
    t.string "contact_email"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["event_id"], name: "index_event_venues_on_event_id"
    t.index ["venue_id"], name: "index_event_venues_on_venue_id"
  end

  create_table "events", force: :cascade do |t|
    t.string "name"
    t.bigint "tour_id"
    t.bigint "venue_id"
    t.date "date"
    t.datetime "start_time"
    t.datetime "end_time"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["tour_id"], name: "index_events_on_tour_id"
    t.index ["venue_id"], name: "index_events_on_venue_id"
  end

  create_table "organization_tours", force: :cascade do |t|
    t.bigint "organization_id"
    t.bigint "tour_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["organization_id"], name: "index_organization_tours_on_organization_id"
    t.index ["tour_id"], name: "index_organization_tours_on_tour_id"
  end

  create_table "organizations", force: :cascade do |t|
    t.string "name"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_organizations_on_user_id"
  end

  create_table "sub_events", force: :cascade do |t|
    t.string "name"
    t.string "description"
    t.bigint "event_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["event_id"], name: "index_sub_events_on_event_id"
  end

  create_table "tours", force: :cascade do |t|
    t.string "name"
    t.date "start_date"
    t.date "end_date"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "organization_id"
    t.index ["organization_id"], name: "index_tours_on_organization_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "firstName"
    t.string "lastName"
    t.string "phone_number"
    t.string "email"
    t.integer "role"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "venues", force: :cascade do |t|
    t.string "name"
    t.string "address"
    t.string "city"
    t.string "state"
    t.string "zip"
    t.integer "capacity"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "event_venues", "events"
  add_foreign_key "event_venues", "venues"
  add_foreign_key "events", "tours"
  add_foreign_key "events", "venues"
  add_foreign_key "organization_tours", "organizations"
  add_foreign_key "organization_tours", "tours"
  add_foreign_key "organizations", "users"
  add_foreign_key "sub_events", "events"
  add_foreign_key "tours", "organizations"
end