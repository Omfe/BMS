json.array!(@beacons) do |beacon|
  json.extract! beacon, :id, :name, :factory_id, :description, :latitude, :longitude, :owner_id
  json.url beacon_url(beacon, format: :json)
end
