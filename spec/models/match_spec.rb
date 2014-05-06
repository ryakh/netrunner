require 'spec_helper'

describe Match do
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
  end
end
