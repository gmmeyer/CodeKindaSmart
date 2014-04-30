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

ActiveRecord::Schema.define(version: 20140430171406) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "annotations", force: true do |t|
    t.string   "title",               null: false
    t.text     "body",                null: false
    t.integer  "user_id",             null: false
    t.integer  "document_id",         null: false
    t.integer  "start_location",      null: false
    t.integer  "end_location",        null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "notifications_count"
    t.integer  "up_votes_count"
    t.integer  "down_votes_count"
  end

  add_index "annotations", ["body"], name: "index_annotations_on_body", using: :btree
  add_index "annotations", ["document_id"], name: "index_annotations_on_document_id", using: :btree
  add_index "annotations", ["start_location", "end_location"], name: "index_annotations_on_start_location_and_end_location", using: :btree
  add_index "annotations", ["title"], name: "index_annotations_on_title", using: :btree
  add_index "annotations", ["user_id"], name: "index_annotations_on_user_id", using: :btree

  create_table "authors", force: true do |t|
    t.string   "name",            null: false
    t.text     "description"
    t.string   "location"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "documents_count"
  end

  add_index "authors", ["name"], name: "index_authors_on_name", unique: true, using: :btree
  add_index "authors", ["user_id"], name: "index_authors_on_user_id", using: :btree

  create_table "documents", force: true do |t|
    t.string   "title",             null: false
    t.text     "summary"
    t.text     "body",              null: false
    t.datetime "release_date"
    t.integer  "user_id",           null: false
    t.integer  "author_id",         null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "annotations_count"
  end

  add_index "documents", ["author_id"], name: "index_documents_on_author_id", using: :btree
  add_index "documents", ["body"], name: "index_documents_on_body", using: :btree
  add_index "documents", ["title"], name: "index_documents_on_title", unique: true, using: :btree
  add_index "documents", ["user_id"], name: "index_documents_on_user_id", using: :btree

  create_table "notifications", force: true do |t|
    t.integer  "user_id"
    t.integer  "notifiable_id"
    t.string   "notifiable_type"
    t.integer  "event_id"
    t.boolean  "is_read"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "pg_search_documents", force: true do |t|
    t.text     "content"
    t.integer  "searchable_id"
    t.string   "searchable_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", force: true do |t|
    t.string   "username",            null: false
    t.string   "email",               null: false
    t.string   "password_digest",     null: false
    t.string   "token"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "notifications_count"
    t.integer  "documents_count"
    t.integer  "up_votes_count"
    t.integer  "down_votes_count"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["token"], name: "index_users_on_token", using: :btree
  add_index "users", ["username", "password_digest"], name: "index_users_on_username_and_password_digest", using: :btree
  add_index "users", ["username"], name: "index_users_on_username", unique: true, using: :btree

  create_table "votes", force: true do |t|
    t.integer  "user_id",             null: false
    t.integer  "annotation_id",       null: false
    t.string   "type",                null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "notifications_count"
  end

  add_index "votes", ["annotation_id"], name: "index_votes_on_annotation_id", using: :btree
  add_index "votes", ["user_id", "annotation_id"], name: "index_votes_on_user_id_and_annotation_id", unique: true, using: :btree
  add_index "votes", ["user_id"], name: "index_votes_on_user_id", using: :btree

end
