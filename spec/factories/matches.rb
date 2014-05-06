FactoryGirl.define do
  factory :match do
    played_on                '2014-05-02'

    association :first_player,  factory: :user
    association :second_player, factory: :user

    association :first_player_corporation,  factory: :identity
    association :first_player_runner,       factory: :identity
    association :second_player_corporation, factory: :identity
    association :second_player_runner,      factory: :identity

    first_player_corporation_points  10
    first_player_runner_points       10
    second_player_corporation_points 4
    second_player_runner_points      4
  end
end
