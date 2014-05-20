require 'spec_helper'

describe Standing do
  let(:event) { create_list(:match, 10).last.event }

  before(:each) do
    create(:season)
    create(:event)
  end

  describe 'generation for event' do
    it 'will update all users who played in event' do
      update_counter = 0
      User.any_instance.stub(:update_attributes) { update_counter += 1 }
      Standing.generate_for_event(event)
      expect(update_counter).to eq(20)
    end

    it 'will generate standing for each user in event' do
      create_counter = 0
      Standing.stub(:create!) { create_counter += 1 }
      Standing.generate_for_event(event)
      expect(create_counter).to eq(20)
    end
  end

  describe 'generation for season' do
    before(:each) do
      Standing.generate_for_event(event)
    end

    it 'will generate standing for each user in season' do
      create_counter = 0
      Standing.stub(:create!) { create_counter += 1 }
      Standing.generate_for_season(event.season)
      expect(create_counter).to eq(20)
    end
  end
end
