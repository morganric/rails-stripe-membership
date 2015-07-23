json.array!(@items) do |item|
  json.extract! item, :id, :title, :about, :user_id
  json.url item_url(item, format: :json)
end
