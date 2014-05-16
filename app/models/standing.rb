class Standing < ActiveRecord::Base
  belongs_to :rateable, polymorphic: true
  belongs_to :user

  def self.generate_for_event(event)
    users       = set_users_from(event)
    user_rating = get_rating_for(users)
    new_rating  = generate_new_rating_from(user_rating, event.matches)

    users.each do |user|
      update_user_rating_and_generate_standings(
        user,
        new_rating.fetch(user.id),
        event,
        event.matches.where(
          "first_player_id = ? OR second_player_id = ?", user.id, user.id
        ).length
      )
    end
  end

  def self.generate_for_season(season)
    season.last_event_standings.each do |s|
      Standing.create!(
        rateable:        season,
        user:            s.user,
        rating:          s.rating,
        deviation:       s.deviation,
        volatility:      s.volatility,
        number_of_games: s.number_of_games
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

    def self.get_rating_for(users)
      Hash[users.map {
        |u| [ u.id, Rating.new(u.rating, u.deviation, u.volatility) ]
      }]
    end

    def self.generate_new_rating_from(user_rating, matches)
      period = Glicko2::RatingPeriod.from_objs user_rating.values

      matches.each do |match|
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

      return user_rating
    end

    def self.update_user_rating_and_generate_standings(user, rating, event, games)
      user.update_attributes(
        rating:          rating.rating,
        deviation:       rating.rating_deviation,
        volatility:      rating.volatility,
        number_of_games: (user.number_of_games + games)
      )

      Standing.create!(
        rateable:        event,
        user:            user,
        rating:          rating.rating,
        deviation:       rating.rating_deviation,
        volatility:      rating.volatility,
        number_of_games: user.number_of_games
      )
    end
end
