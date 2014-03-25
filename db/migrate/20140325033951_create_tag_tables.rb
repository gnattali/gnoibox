class CreateTagTables < ActiveRecord::Migration
  def change
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
      t.string "name"
    end

    add_index "tags", ["name"], name: "index_tags_on_name", unique: true
  end
end
