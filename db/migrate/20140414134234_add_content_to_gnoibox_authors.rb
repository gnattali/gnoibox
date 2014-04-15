class AddContentToGnoiboxAuthors < ActiveRecord::Migration
  def change
    add_column :gnoibox_authors, :name, :string
    add_column :gnoibox_authors, :image, :string
    add_column :gnoibox_authors, :google_plus_id, :string
    add_column :gnoibox_authors, :description, :text
    add_column :gnoibox_authors, :content, :text
  end
end
