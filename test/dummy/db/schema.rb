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

ActiveRecord::Schema.define(version: 20140911220525) do

  create_table "gnoibox_authors", force: true do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "name"
    t.string   "image"
    t.string   "google_plus_id"
    t.text     "description"
    t.text     "content"
    t.string   "role"
  end

  add_index "gnoibox_authors", ["email"], name: "index_gnoibox_authors_on_email", unique: true
  add_index "gnoibox_authors", ["reset_password_token"], name: "index_gnoibox_authors_on_reset_password_token", unique: true

  create_table "gnoibox_blocks", force: true do |t|
    t.string   "key"
    t.text     "content"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "gnoibox_blocks", ["key"], name: "index_gnoibox_blocks_on_key"

  create_table "gnoibox_inquiries", force: true do |t|
    t.string   "form_key"
    t.string   "email"
    t.text     "content"
    t.string   "status"
    t.datetime "checked_at"
    t.string   "box_key"
    t.integer  "gnoibox_item_id"
    t.integer  "gnoibox_user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "gnoibox_items", force: true do |t|
    t.string   "box_key"
    t.string   "url"
    t.text     "description"
    t.text     "content"
    t.string   "title"
    t.string   "keywords"
    t.string   "view_file"
    t.datetime "published_at"
    t.string   "main_image"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "order_value"
    t.integer  "gnoibox_author_id"
    t.string   "status"
  end

  add_index "gnoibox_items", ["box_key"], name: "index_gnoibox_items_on_box_key"
  add_index "gnoibox_items", ["url"], name: "index_gnoibox_items_on_url"

  create_table "gnoibox_users", force: true do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "signed_up_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "gnoibox_users", ["email"], name: "index_gnoibox_users_on_email", unique: true
  add_index "gnoibox_users", ["reset_password_token"], name: "index_gnoibox_users_on_reset_password_token", unique: true

  create_table "taggings", force: true do |t|
    t.integer  "tag_id"
    t.integer  "taggable_id"
    t.string   "taggable_type"
    t.integer  "tagger_id"
    t.string   "tagger_type"
    t.string   "context",       limit: 128
    t.datetime "created_at"
  end

  add_index "taggings", ["tag_id", "taggable_id", "taggable_type", "context", "tagger_id", "tagger_type"], name: "taggings_idx", unique: true

  create_table "tags", force: true do |t|
    t.string  "name"
    t.integer "taggings_count", default: 0
  end

  add_index "tags", ["name"], name: "index_tags_on_name", unique: true

end
