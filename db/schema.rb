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

ActiveRecord::Schema.define(version: 2021_09_24_191840) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "meeting_durations", force: :cascade do |t|
    t.bigint "survey_response_id", null: false
    t.datetime "started_at"
    t.integer "minutes"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["survey_response_id"], name: "index_meeting_durations_on_survey_response_id"
  end

  create_table "students", force: :cascade do |t|
    t.string "name", null: false
    t.string "email"
    t.date "date_of_birth"
    t.string "location"
    t.string "phone_number"
    t.string "preferred_contact_method"
    t.datetime "archived_at"
    t.string "nickname"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "students_users", force: :cascade do |t|
    t.bigint "student_id", null: false
    t.bigint "user_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["student_id"], name: "index_students_users_on_student_id"
    t.index ["user_id"], name: "index_students_users_on_user_id"
  end

  create_table "survey_question_responses", force: :cascade do |t|
    t.bigint "survey_response_id", null: false
    t.bigint "survey_question_id", null: false
    t.text "reply", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["survey_question_id"], name: "index_survey_question_responses_on_survey_question_id"
    t.index ["survey_response_id"], name: "index_survey_question_responses_on_survey_response_id"
  end

  create_table "survey_questions", force: :cascade do |t|
    t.bigint "survey_id", null: false
    t.string "type"
    t.text "prompt"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["survey_id"], name: "index_survey_questions_on_survey_id"
  end

  create_table "survey_responses", force: :cascade do |t|
    t.bigint "survey_id", null: false
    t.bigint "user_id", null: false
    t.bigint "student_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["student_id"], name: "index_survey_responses_on_student_id"
    t.index ["survey_id"], name: "index_survey_responses_on_survey_id"
    t.index ["user_id"], name: "index_survey_responses_on_user_id"
  end

  create_table "surveys", force: :cascade do |t|
    t.string "name", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.integer "role", default: 0, null: false
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "students_users", "students"
  add_foreign_key "students_users", "users"
  add_foreign_key "survey_questions", "surveys"
  add_foreign_key "survey_responses", "students"
  add_foreign_key "survey_responses", "surveys"
  add_foreign_key "survey_responses", "users"
end
