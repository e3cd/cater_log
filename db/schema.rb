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


ActiveRecord::Schema.define(version: 2018_10_30_014926) do

ActiveRecord::Schema.define(version: 2018_10_30_014446) do


  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "caterer_informations", force: :cascade do |t|
    t.string "name"
    t.text "number"
    t.text "address"
    t.text "image"
    t.text "about"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_caterer_informations_on_user_id"
  end

  create_table "caterer_menus", force: :cascade do |t|
    t.text "description"
    t.decimal "price"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end


  create_table "conversations", force: :cascade do |t|
    t.integer "caterer_id"
    t.integer "customer_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "histories", force: :cascade do |t|
    t.date "booking_date"
    t.integer "user_id"
    t.integer "caterermenu_id"
    t.decimal "price"
    t.text "stripe_charge_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end


  create_table "messages", force: :cascade do |t|
    t.text "content"
    t.integer "user_id"
    t.integer "conversation_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false

  end

  create_table "reviews", force: :cascade do |t|
    t.integer "rating"
    t.text "content"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false

    t.index ["user_id"], name: "index_reviews_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "is_caterer?"
    t.bigint "user_id"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
    t.index ["user_id"], name: "index_users_on_user_id"
  end

  add_foreign_key "caterer_informations", "users"
  add_foreign_key "reviews", "users"

  add_foreign_key "users", "users"

end
