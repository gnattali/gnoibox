class CreateGnoiboxInquiries < ActiveRecord::Migration
  def change
    create_table :gnoibox_inquiries do |t|
      t.string :form_key
      t.string :email
      t.text :content
      t.string :status
      t.datetime :checked_at
      t.string :box_key
      t.integer :gnoibox_item_id
      t.integer :gnoibox_user_id
    end
  end
end
