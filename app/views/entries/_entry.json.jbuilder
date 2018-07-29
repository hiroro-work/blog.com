json.extract! entry, :id, :title, :body, :blog_id, :created_at, :updated_at
json.url blog_entry_url(@blog, entry, format: :json)
