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

ActiveRecord::Schema.define(version: 20151008154022) do

  create_table "acquirements", force: :cascade do |t|
    t.integer  "level"
    t.integer  "hacker_id"
    t.integer  "skill_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "acquirements", ["hacker_id"], name: "index_acquirements_on_hacker_id"
  add_index "acquirements", ["skill_id"], name: "index_acquirements_on_skill_id"

  create_table "careers", force: :cascade do |t|
    t.string   "name"
    t.text     "description"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "careers", ["name"], name: "index_careers_on_name", unique: true

  create_table "hackers", force: :cascade do |t|
    t.string   "name"
    t.string   "email"
    t.string   "password_digest"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.integer  "career_id"
  end

  add_index "hackers", ["career_id"], name: "index_hackers_on_career_id"
  add_index "hackers", ["email"], name: "index_hackers_on_email", unique: true

  create_table "requirements", force: :cascade do |t|
    t.integer  "level"
    t.integer  "skill_id"
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
    t.integer  "seniority",  default: 0, null: false
    t.integer  "career_id"
  end

  add_index "requirements", ["career_id"], name: "index_requirements_on_career_id"
  add_index "requirements", ["seniority"], name: "index_requirements_on_seniority"
  add_index "requirements", ["skill_id"], name: "index_requirements_on_skill_id"

  create_table "skills", force: :cascade do |t|
    t.string   "name"
    t.text     "description"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "skills", ["name"], name: "index_skills_on_name", unique: true

end
