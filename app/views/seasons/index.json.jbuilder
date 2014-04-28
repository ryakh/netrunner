json.array!(@seasons) do |season|
  json.extract! season, :id, :name, :is_active
  json.url season_url(season, format: :json)
end
