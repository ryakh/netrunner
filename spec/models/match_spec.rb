require 'spec_helper'

describe Match do
  let(:match) { create(:match) }

  describe 'creation' do
    it 'create event if there is no unclosed event running' do
      expect {
        create(:match)
      }.to change(Event, :count).by(1)
    end

    it 'wont create event if there is one running' do
      create(:event)

      expect {
        create(:match)
      }.to change(Event, :count).by(0)
    end

    it 'sets match event before creation' do
      event = create(:event)
      expect(match.event).to eq(event)
    end

    describe 'league point calculation' do
      it 'gives both players 3 points' do
        event = create(
          :match,
          first_player_corporation_points:  10,
          first_player_runner_points:       4,
          second_player_corporation_points: 4,
          second_player_runner_points:      10
        )

        expect(event.first_player_league_points).to eq(3)
        expect(event.second_player_league_points).to eq(3)
      end

      it 'sets first player to absolute winner' do
        event = create(
          :match,
          first_player_corporation_points:  10,
          first_player_runner_points:       10,
          second_player_corporation_points: 4,
          second_player_runner_points:      4
        )

        expect(event.first_player_league_points).to eq(6)
        expect(event.second_player_league_points).to eq(0)
      end

      it 'sets second player to absolute winner' do
        event = create(
          :match,
          first_player_corporation_points:  2,
          first_player_runner_points:       6,
          second_player_corporation_points: 10,
          second_player_runner_points:      10
        )

        expect(event.first_player_league_points).to eq(0)
        expect(event.second_player_league_points).to eq(6)
      end

      it 'gives first player modified win' do
        event = create(
          :match,
          first_player_corporation_points:  10,
          first_player_runner_points:       6,
          second_player_corporation_points: 10,
          second_player_runner_points:      2
        )

        expect(event.first_player_league_points).to eq(4)
        expect(event.second_player_league_points).to eq(2)
      end

      it 'gives second player modified win' do
        event = create(
          :match,
          first_player_corporation_points:  10,
          first_player_runner_points:       2,
          second_player_corporation_points: 10,
          second_player_runner_points:      6
        )

        expect(event.first_player_league_points).to eq(2)
        expect(event.second_player_league_points).to eq(4)
      end
    end
  end
end
