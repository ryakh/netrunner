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
  end
end
