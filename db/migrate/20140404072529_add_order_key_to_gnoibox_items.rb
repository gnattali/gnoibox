class AddOrderKeyToGnoiboxItems < ActiveRecord::Migration
  def change
    add_column :gnoibox_items, :order_key, :string
  end
end
