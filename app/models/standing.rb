class Standing < ActiveRecord::Base
  belongs_to :rateable, polymorphic: true
  belongs_to :user

  def self.generate_for_event(event)
    users       = set_users_from(event)
    user_rating = generate_rating_for(users)

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

  def self.generate_for_season(season)
    season.events.last.standings.each do |s|
      Standing.create!(
        rateable:   season,
        user:       s.user,
        rating:     s.rating,
        deviation:  s.deviation,
        volatility: s.volatility
      )
    end
  end

  private
    def self.set_users_from(event)
      current_event_players = event.matches.pluck(
        :first_player_id,
        :second_player_id
      )

      past_event_players = Standing.where(rateable: event.season.events).pluck(
        :user_id
      )

      User.where(id: (current_event_players + past_event_players).flatten.sort.uniq)
    end

    def self.generate_rating_for(users)
      Hash[users.map {
        |u| [ u.id, Rating.new(u.rating, u.deviation, u.volatility) ]
      }]
    end
end