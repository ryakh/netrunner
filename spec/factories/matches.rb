# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :match do
    played_on "2014-05-02"
    first_player nil
    second_player nil
    first_player_corporation nil
    first_player_runner nil
    second_player_corporation nil
    second_player_runner nil
    first_player_corporation_points 1
    first_player_runner_points 1
    second_player_corporation_points 1
    second_player_runner_points 1
    first_player_league_points 1
    second_player_league_points 1
  end
end
