class AddBoxKeyIndexToGnoiboxItems < ActiveRecord::Migration
  def change
    add_column :gnoibox_items, :gnoibox_author_id, :integer

    add_index "gnoibox_items", ["box_key"], name: "index_gnoibox_items_on_box_key"
    add_index "gnoibox_items", ["url"], name: "index_gnoibox_items_on_url"
  end
end
