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

ActiveRecord::Schema.define(version: 20190316222217) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "countries", force: :cascade do |t|
    t.string "name"
    t.string "code"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "functions", force: :cascade do |t|
    t.bigint "hub_id"
    t.string "code"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["hub_id"], name: "index_functions_on_hub_id"
  end

  create_table "hubs", force: :cascade do |t|
    t.bigint "country_id"
    t.string "status"
    t.string "name"
    t.string "name_wo_diacritics"
    t.date "uploaded_date"
    t.string "iata"
    t.string "remark"
    t.string "change_code"
    t.string "subdiv"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "code"
    t.string "unlocode"
    t.index ["country_id"], name: "index_hubs_on_country_id"
  end

  create_table "locations", force: :cascade do |t|
    t.float "lat"
    t.float "long"
    t.bigint "hub_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["hub_id"], name: "index_locations_on_hub_id"
  end

  add_foreign_key "functions", "hubs"
  add_foreign_key "hubs", "countries"
  add_foreign_key "locations", "hubs"
end
