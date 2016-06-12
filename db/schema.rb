# This file is auto-generated from the current state of the database. Instead of editing this file, 
# please use the migrations feature of Active Record to incrementally modify your database, and
# then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your database schema. If you need
# to create the application database on another system, you should be using db:schema:load, not running
# all the migrations from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20100819201350) do

  create_table "papers", :force => true do |t|
    t.string   "title"
    t.integer  "year"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "page_start"
    t.string   "page_end"
    t.string   "kind"
    t.string   "address"
    t.string   "author"
    t.string   "booktitle"
    t.string   "editor"
    t.string   "institution"
    t.string   "journal"
    t.string   "url"
    t.string   "month"
    t.string   "note"
    t.integer  "num_accepted"
    t.integer  "num_submitted"
    t.string   "number"
    t.string   "organization"
    t.string   "publisher"
    t.string   "series"
    t.string   "volume"
    t.boolean  "invited"
    t.string   "doi"
    t.string   "article_number"
    t.string   "school"
    t.boolean  "draft"
    t.boolean  "hidden"
  end

  create_table "papers_tags", :id => false, :force => true do |t|
    t.integer "paper_id"
    t.integer "tag_id"
  end

  create_table "tags", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
