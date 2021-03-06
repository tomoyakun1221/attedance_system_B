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

<<<<<<< HEAD
ActiveRecord::Schema.define(version: 20191104133033) do
=======
ActiveRecord::Schema.define(version: 20191030164441) do
>>>>>>> 2bd5adf2fe1132420affc68ac87363a2b8f9e962

  create_table "attendances", force: :cascade do |t|
    t.date "worked_on"
    t.datetime "started_at"
    t.datetime "finished_at"
    t.string "note"
    t.integer "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_attendances_on_user_id"
  end

  create_table "points", force: :cascade do |t|
    t.integer "point_number"
    t.string "point_name"
    t.string "point_type"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "password_digest"
    t.string "remember_digest"
    t.boolean "admin", default: false
    t.string "department"
<<<<<<< HEAD
    t.datetime "basic_time", default: "2019-11-03 23:00:00"
    t.datetime "work_time", default: "2019-11-03 22:30:00"
    t.integer "employee_number"
    t.datetime "user_designated_work_start_time", default: "2019-11-04 00:00:00"
    t.datetime "user_designated_work_end_time", default: "2019-11-04 09:00:00"
    t.string "user_card_id"
    t.integer "decision"
    t.boolean "superior", default: false
=======
    t.datetime "basic_time", default: "2019-10-30 23:00:00"
    t.datetime "work_time", default: "2019-10-30 22:30:00"
    t.integer "employee_number"
    t.datetime "user_designated_work_start_time", default: "2019-10-31 00:00:00"
    t.datetime "user_designated_work_end_time", default: "2019-10-31 09:00:00"
    t.integer "user_card_id"
>>>>>>> 2bd5adf2fe1132420affc68ac87363a2b8f9e962
  end

end
