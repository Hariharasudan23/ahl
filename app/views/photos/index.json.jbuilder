json.array!(@photos) do |photo|
  json.extract! photo, :id, :match_id
  json.photo image_path(photo.picture_url)
end
