json.array!(@projects) do |project|
  json.extract! project, :id, :title, :description, :cover, :images, :image, :video, :user_id, :slug
  json.url project_url(project, format: :json)
end
