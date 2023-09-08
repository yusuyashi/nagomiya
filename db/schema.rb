# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2023_09_08_145912) do

  create_table "reservation_details", force: :cascade do |t|
    t.integer "service_menu_id", null: false
    t.integer "customer_id", null: false
    t.integer "therapist_id", null: false
    t.integer "unit_price", null: false
    t.integer "subtotal", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "reservations", force: :cascade do |t|
    t.integer "service_menu_id", null: false
    t.integer "customer_id", null: false
    t.integer "therapist_id", null: false
    t.datetime "visit_datetime", null: false
    t.integer "total_amount", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "reviews", force: :cascade do |t|
    t.integer "customer_id", null: false
    t.integer "rating", null: false
    t.string "comment", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "service_menus", force: :cascade do |t|
    t.string "course_name", null: false
    t.integer "price_incl_tax", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "therapists", force: :cascade do |t|
    t.string "therapist_name", null: false
    t.integer "experience_years", null: false
    t.text "introduction", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

end
