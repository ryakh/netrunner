class Standing < ActiveRecord::Base
  belongs_to :rateable, polymorphic: true
  belongs_to :user

  def self.generate_for_event(event)
    player_ids = event.matches.
      pluck(:first_player_id, :second_player_id).
      flatten.
      sort.
      uniq

    users = User.where(id: player_ids)

    user_rating = {}

    users.each do |u|
      user_rating[u.id] = Rating.new(u.rating, u.deviation, u.volatility)
    end

    period = Glicko2::RatingPeriod.from_objs user_rating.values

    event.matches.each do |match|
      period.game(
        [
          user_rating.fetch(match.first_player_id),
          user_rating.fetch(match.second_player_id)
        ],

        [
          match.first_player_league_points,
          match.second_player_league_points
        ]
      )
    end

    next_period = period.generate_next
    next_period.players.each { |p| p.update_obj }

    users.each do |u|
      rating = user_rating.fetch(u.id)

      u.update_attributes(
        rating:     rating.rating,
        deviation:  rating.rating_deviation,
        volatility: rating.volatility
      )

      Standing.create!(
        rateable:   event,
        user:       u,
        rating:     rating.rating,
        deviation:  rating.rating_deviation,
        volatility: rating.volatility
      )
    end
  end
end
