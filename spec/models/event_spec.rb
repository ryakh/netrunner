require 'spec_helper'

describe Event do
  it 'sets season before creating an event' do
    season = create(:season)
    event = create(:event)
    expect(event.season).to eq(season)
  end

  describe 'weekly setup' do
    describe 'with a season running' do
      before(:each) do
        create(:season, is_active: true)
        create(:event)
      end

      it 'closes the current week' do
        Event.should_receive(:close_current_week)
        Event.weekly_setup
      end

      it 'deletes event with no matches' do
        expect {
          Event.send(:close_current_week)
        }.to change(Event, :count).by(-1)
      end

      it 'closes event with matches played' do
        create(:event)
        create(:match)
        Event.send(:close_current_week)
        expect(Event.first.is_closed).to be_true
      end

      it 'triggers start_new_week method' do
        Event.should_receive(:start_new_week)
        Event.weekly_setup
      end
    end

    describe 'with no season running' do
      before(:each) do
        create(:event)
      end

      it 'wont create new event' do
        expect {
          Event.weekly_setup
        }.not_to change(Event, :count)
      end
    end
  end
end
