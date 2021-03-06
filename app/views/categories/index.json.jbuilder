json.array!(@categories) do |category|
  json.extract! category, :id, :name, :user_id, :slug
  json.url category_url(category, format: :json)
end
