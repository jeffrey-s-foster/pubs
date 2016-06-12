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

ActiveRecord::Schema.define(version: 20160612185703) do

  create_table "papers", force: :cascade do |t|
    t.string   "title",          limit: 255
    t.integer  "year"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "page_start",     limit: 255
    t.string   "page_end",       limit: 255
    t.string   "kind",           limit: 255
    t.string   "address",        limit: 255
    t.string   "author",         limit: 255
    t.string   "booktitle",      limit: 255
    t.string   "editor",         limit: 255
    t.string   "institution",    limit: 255
    t.string   "journal",        limit: 255
    t.string   "url",            limit: 255
    t.string   "month",          limit: 255
    t.string   "note",           limit: 255
    t.integer  "num_accepted"
    t.integer  "num_submitted"
    t.string   "number",         limit: 255
    t.string   "organization",   limit: 255
    t.string   "publisher",      limit: 255
    t.string   "series",         limit: 255
    t.string   "volume",         limit: 255
    t.boolean  "invited"
    t.string   "doi",            limit: 255
    t.string   "article_number", limit: 255
    t.string   "school",         limit: 255
    t.boolean  "draft"
    t.boolean  "hidden"
  end

  create_table "papers_tags", id: false, force: :cascade do |t|
    t.integer "paper_id"
    t.integer "tag_id"
  end

  create_table "sessions", force: :cascade do |t|
    t.string   "session_id", null: false
    t.string   "cas_ticket"
    t.text     "data"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "sessions", ["cas_ticket"], name: "index_sessions_on_cas_ticket"
  add_index "sessions", ["session_id"], name: "index_sessions_on_session_id"
  add_index "sessions", ["updated_at"], name: "index_sessions_on_updated_at"

  create_table "tags", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
