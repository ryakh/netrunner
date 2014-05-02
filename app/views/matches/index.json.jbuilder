json.array!(@matches) do |match|
  json.extract! match, :id, :played_on, :first_player_id, :second_player_id, :first_player_corporation_id, :first_player_runner_id, :second_player_corporation_id, :second_player_runner_id, :first_player_corporation_points, :first_player_runner_points, :second_player_corporation_points, :second_player_runner_points, :first_player_league_points, :second_player_league_points
  json.url match_url(match, format: :json)
end
