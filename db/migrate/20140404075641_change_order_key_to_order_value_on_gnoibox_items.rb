class ChangeOrderKeyToOrderValueOnGnoiboxItems < ActiveRecord::Migration
  def change
    rename_column :gnoibox_items, :order_key, :order_value
  end
end
