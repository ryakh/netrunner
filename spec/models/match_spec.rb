require 'spec_helper'

describe Match do
  let(:match) { create(:match) }

  describe 'creation' do
    it 'sets match event before creation' do
      event = Event.create_current
      create(:match)
      expect(match.event).to eq(event)
    end

    describe 'league point calculation' do
      it 'gives both players 3 points' do
        event = create(
          :match,
          first_player_corporation_points:  10,
          first_player_runner_points:       4,
          second_player_corporation_points: 10,
          second_player_runner_points:      4
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

    describe 'validation' do
      it 'expects user to be unique' do
        user = create(:user)

        expect {
          create(
            :match,
            first_player: user,
            second_player: user
          )
        }.to raise_error
      end

      it 'expects points summary to be less than 32' do
        expect {
          create(
            :match,
            first_player_corporation_points:  10,
            first_player_runner_points:       10,
            second_player_corporation_points: 10,
            second_player_runner_points:      10
          )
        }.to raise_error
      end

      it 'expects points summary to be more or equal to 20' do
        expect {
          create(
            :match,
            first_player_corporation_points:  10,
            first_player_runner_points:       9,
            second_player_corporation_points: 0,
            second_player_runner_points:      0
          )
        }.to raise_error
      end

      it 'expect match result to contain exactly 2 wins' do
        expect {
          create(
            :match,
            first_player_corporation_points:  10,
            first_player_runner_points:       9,
            second_player_corporation_points: 5,
            second_player_runner_points:      0
          )
        }.to raise_error

        expect {
          create(
            :match,
            first_player_corporation_points:  10,
            first_player_runner_points:       10,
            second_player_corporation_points: 10,
            second_player_runner_points:      0
          )
        }.to raise_error
      end

      it 'expects the sum of loses not to exceed 12' do
        expect {
          create(
            :match,
            first_player_corporation_points:  10,
            first_player_runner_points:       10,
            second_player_corporation_points: 6,
            second_player_runner_points:      7
          )
        }.to raise_error
      end

      it 'expects tha date on which match was played not to be in the future' do
        expect {
          create(
            :match,
            played_on: Time.current + 1.week
          )
        }.to raise_error
      end

      it 'expects event not to be closed' do
        expect {
          create(
            :match,
            is_closed: true
          )
        }.to raise_error
      end

      it 'expects match to have valid score distribution' do
        expect {
          create(
            :match,
            first_player_corporation_points:  10,
            first_player_runner_points:       1,
            second_player_corporation_points: 6,
            second_player_runner_points:      10
          )
        }.to raise_error

        expect {
          create(
            :match,
            first_player_corporation_points:  1,
            first_player_runner_points:       10,
            second_player_corporation_points: 10,
            second_player_runner_points:      7
          )
        }.to raise_error
      end
    end
  end
end
