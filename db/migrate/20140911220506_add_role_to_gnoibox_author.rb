class AddRoleToGnoiboxAuthor < ActiveRecord::Migration
  def change
    add_column :gnoibox_authors, :role, :string

    Gnoibox::Author.reset_column_information
    reversible do |dir|
      dir.up { Gnoibox::Author.update_all(role: :admin) }
    end

  end
end
