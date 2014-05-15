require 'spec_helper'

describe Season do
  let(:season) { create(:season) }

  describe 'close' do
    it 'triggers standings generation' do
      Standing.should_receive(:generate_for_season)
      season.close
    end

    it 'triggers user rating reset' do
      User.should_receive(:reset_ratings)
      season.close
    end

    it 'sets is_active attribute to false' do
      season.close
      expect(season.is_active).to be_false
    end
  end
end
