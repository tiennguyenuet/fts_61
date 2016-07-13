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

ActiveRecord::Schema.define(version: 20160713095903) do

  create_table "activities", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "target_id"
    t.string   "target_type"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "activities", ["user_id"], name: "index_activities_on_user_id"

  create_table "answers", force: :cascade do |t|
    t.integer  "question_id"
    t.string   "content"
    t.boolean  "is_correct"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "answers", ["question_id"], name: "index_answers_on_question_id"

  create_table "examinations", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "subject_id"
    t.integer  "status"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "examinations", ["subject_id"], name: "index_examinations_on_subject_id"
  add_index "examinations", ["user_id"], name: "index_examinations_on_user_id"

  create_table "questions", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "subject_id"
    t.integer  "question_type"
    t.string   "content"
    t.string   "state"
    t.string   "integer"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  add_index "questions", ["subject_id"], name: "index_questions_on_subject_id"
  add_index "questions", ["user_id"], name: "index_questions_on_user_id"

  create_table "results", force: :cascade do |t|
    t.integer  "examination_id"
    t.integer  "question_id"
    t.integer  "answer_id"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
  end

  add_index "results", ["answer_id"], name: "index_results_on_answer_id"
  add_index "results", ["examination_id"], name: "index_results_on_examination_id"
  add_index "results", ["question_id"], name: "index_results_on_question_id"

  create_table "subjects", force: :cascade do |t|
    t.string   "name"
    t.string   "description"
    t.integer  "total_question"
    t.integer  "duration"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "name"
    t.string   "email"
    t.string   "avatar"
    t.integer  "role"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
