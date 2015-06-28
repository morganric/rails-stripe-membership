json.array!(@profiles) do |profile|
  json.extract! profile, :id, :first_name, :second_name, :image, :bio, :twitter, :cover, :user_id
  json.url profile_url(profile, format: :json)
end
