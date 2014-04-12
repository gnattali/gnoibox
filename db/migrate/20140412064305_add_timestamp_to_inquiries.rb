class AddTimestampToInquiries < ActiveRecord::Migration
  def change
    add_column :gnoibox_inquiries, :created_at, :datetime
    add_column :gnoibox_inquiries, :updated_at, :datetime
  end
end
