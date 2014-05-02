class CreateMatches < ActiveRecord::Migration
  def change
    create_table :matches do |t|
      t.date       :played_on

      t.integer    :first_player_id
      t.integer    :second_player_id
      t.integer    :first_player_corporation_id
      t.integer    :first_player_runner_id
      t.integer    :second_player_corporation_id
      t.integer    :second_player_runner_id

      t.integer :first_player_corporation_points
      t.integer :first_player_runner_points
      t.integer :second_player_corporation_points
      t.integer :second_player_runner_points
      t.integer :first_player_league_points
      t.integer :second_player_league_points

      t.timestamps
    end

    add_index :matches, :first_player_id
    add_index :matches, :second_player_id
    add_index :matches, :first_player_corporation_id
    add_index :matches, :first_player_runner_id
    add_index :matches, :second_player_corporation_id
    add_index :matches, :second_player_runner_id
  end
end
