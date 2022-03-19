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

ActiveRecord::Schema.define(version: 2022_03_19_075759) do

  create_table "answers", force: :cascade do |t|
    t.integer "user_id", null: false
    t.integer "problem_id", null: false
    t.boolean "result", default: false, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id", "problem_id"], name: "index_answers_on_user_id_and_problem_id", unique: true
    t.index ["user_id"], name: "index_answers_on_user_id"
  end

  create_table "feedbacks", force: :cascade do |t|
    t.integer "user_id", null: false
    t.integer "problem_id", null: false
    t.text "text", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["problem_id"], name: "index_feedbacks_on_problem_id"
    t.index ["user_id"], name: "index_feedbacks_on_user_id"
  end

  create_table "problems", force: :cascade do |t|
    t.integer "user_id", null: false
    t.string "title", null: false
    t.text "statement", null: false
    t.string "answer", null: false
    t.string "incorrect1", null: false
    t.string "incorrect2", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_problems_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.string "name", null: false
    t.integer "point", default: 0, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["point"], name: "index_users_on_point"
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

end
