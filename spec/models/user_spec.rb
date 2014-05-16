require 'spec_helper'

describe User do
  it 'resets rating for all users' do
    create(:user, rating: 1400, deviation: 0, volatility: 0)

    User.reset_ratings

    User.all.each do |user|
      expect(user.rating.to_f).to eq(1500)
      expect(user.deviation.to_f).to eq(350)
      expect(user.volatility.to_f).to eq(0.06)
      expect(user.number_of_games.to_f).to eq(0)
    end
  end
end
