class CreateGnoiboxStructures < ActiveRecord::Migration
  def change
    create_table "gnoibox_blocks", force: true do |t|
      t.string   "key"
      t.text     "content"
      t.datetime "created_at"
      t.datetime "updated_at"
    end

    add_index "gnoibox_blocks", ["key"], name: "index_gnoibox_blocks_on_key"

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
    end

  end
end
