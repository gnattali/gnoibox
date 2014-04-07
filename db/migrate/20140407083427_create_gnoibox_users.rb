class CreateGnoiboxUsers < ActiveRecord::Migration
  def change
    create_table :gnoibox_users do |t|
      t.string   "email",                  default: "", null: false
      t.string   "encrypted_password",     default: "", null: false
      t.string   "reset_password_token"
      t.datetime "reset_password_sent_at"
      t.datetime "remember_created_at"
      t.integer  "sign_in_count",          default: 0,  null: false
      t.datetime "current_sign_in_at"
      t.datetime "last_sign_in_at"
      t.string   "current_sign_in_ip"
      t.string   "last_sign_in_ip"

      t.datetime :signed_up_at

      t.datetime "created_at"
      t.datetime "updated_at"
    end

    add_index "gnoibox_users", ["email"], name: "index_gnoibox_users_on_email", unique: true
    add_index "gnoibox_users", ["reset_password_token"], name: "index_gnoibox_users_on_reset_password_token", unique: true
  end
end
