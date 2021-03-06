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

ActiveRecord::Schema.define(version: 20160131021855) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "answers", force: :cascade do |t|
    t.text     "answer",        null: false
    t.integer  "question_id",   null: false
    t.integer  "enrollment_id", null: false
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  add_index "answers", ["enrollment_id"], name: "index_answers_on_enrollment_id", using: :btree
  add_index "answers", ["question_id"], name: "index_answers_on_question_id", using: :btree

  create_table "courses", force: :cascade do |t|
    t.string   "title",       null: false
    t.string   "description", null: false
    t.string   "icon"
    t.string   "passcode",    null: false
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "enrollments", force: :cascade do |t|
    t.integer  "course_id",                      null: false
    t.integer  "user_id",                        null: false
    t.string   "role",       default: "learner", null: false
    t.datetime "created_at",                     null: false
    t.datetime "updated_at",                     null: false
  end

  add_index "enrollments", ["course_id"], name: "index_enrollments_on_course_id", using: :btree
  add_index "enrollments", ["user_id"], name: "index_enrollments_on_user_id", using: :btree

  create_table "lessons", force: :cascade do |t|
    t.integer  "course_id",  null: false
    t.string   "title",      null: false
    t.text     "content",    null: false
    t.integer  "lesson_no",  null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "lessons", ["course_id"], name: "index_lessons_on_course_id", using: :btree

  create_table "pg_search_documents", force: :cascade do |t|
    t.text     "content"
    t.integer  "searchable_id"
    t.string   "searchable_type"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  add_index "pg_search_documents", ["searchable_type", "searchable_id"], name: "index_pg_search_documents_on_searchable_type_and_searchable_id", using: :btree

  create_table "questions", force: :cascade do |t|
    t.string   "question",   null: false
    t.integer  "lesson_id",  null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "questions", ["lesson_id"], name: "index_questions_on_lesson_id", using: :btree

  create_table "texts", force: :cascade do |t|
    t.string   "text"
    t.integer  "enrollment_id", null: false
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  add_index "texts", ["enrollment_id"], name: "index_texts_on_enrollment_id", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "role",                   default: "member", null: false
    t.string   "first_name",                                null: false
    t.string   "last_name",                                 null: false
    t.string   "profile_photo"
    t.string   "email",                  default: "",       null: false
    t.string   "encrypted_password",     default: "",       null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,        null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.datetime "created_at",                                null: false
    t.datetime "updated_at",                                null: false
    t.integer  "area_code"
    t.integer  "first_digits"
    t.integer  "last_digits"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

end
