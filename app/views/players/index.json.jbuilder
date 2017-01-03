json.array!(@players) do |player|
  json.extract! player, :id, :name, :age, :position, :goals
  json.team player.team.name
  json.photo image_path(player.photo_url)
  json.url player_url(player, format: :json)
end
