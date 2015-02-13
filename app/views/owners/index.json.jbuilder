json.array!(@owners) do |owner|
  json.extract! owner, :id, :name, :image, :description, :owner_type
  json.url owner_url(owner, format: :json)
end
