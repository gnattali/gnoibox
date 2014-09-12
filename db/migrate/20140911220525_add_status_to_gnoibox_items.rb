class AddStatusToGnoiboxItems < ActiveRecord::Migration
  def change
    add_column :gnoibox_items, :status, :string

    Gnoibox::Item.reset_column_information
    reversible do |dir|
      dir.up { Gnoibox::Item.update_all(status: :published) }
    end
  end
end
