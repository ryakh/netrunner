class AddGamesPlayedToStandings < ActiveRecord::Migration
  def change
    add_column :standings, :number_of_games, :integer, default: 0
  end
end
