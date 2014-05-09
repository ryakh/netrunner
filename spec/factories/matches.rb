FactoryGirl.define do
  factory :match do
    played_on                '2014-05-02'

    first_player_corporation_points  10
    first_player_runner_points       10
    second_player_corporation_points 4
    second_player_runner_points      4

    first_player_id do |match|
      create(:user).id
    end

    second_player_id do |match|
      create(:user).id
    end

    first_player_corporation_id do |match|
      create(:identity).id
    end

    first_player_runner_id do |match|
      create(:identity).id
    end

    second_player_corporation_id do |match|
      create(:identity).id
    end

    second_player_runner_id do |match|
      create(:identity).id
    end
  end
end
