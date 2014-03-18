json.array!(@admin_items) do |admin_item|
  json.extract! admin_item, :id, :url, :published_at, :view_file, :title, :description, :keywords
  json.url admin_item_url(admin_item, format: :json)
end
