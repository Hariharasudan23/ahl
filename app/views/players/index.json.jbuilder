json.array!(@players) do |player|
  json.extract! player, :id, :name, :age, :position, :goals
  json.url player_url(player, format: :json)
end
