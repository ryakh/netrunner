class MatchValidator < ActiveModel::Validator
  def validate(record)
    validate_match_summary_for(record)
    validate_players_for(record)
    validate_score_for(record)
    validate_date_of_match_for(record)
    check_if_event_is_rated_for(record)
  end

  private
    def validate_match_summary_for(record)
      unless record.match_points.include?(nil)
        summary = record.match_points.inject(:+)

        if summary > 32 || summary < 20
          record.errors[:base] << 'Sum of match points can not exceed 32
                                   or be less than 20'
        end
      end
    end

    def validate_players_for(record)
      unless record.first_player.nil? || record.second_player_id.nil?
        if record.first_player_id == record.second_player_id
          record.errors[:base] << 'You can not play with yourself, DOH!'
        end
      end
    end

    def validate_score_for(record)
      unless record.match_points.include?(nil)
        result = record.match_points
        result.delete(10)

        if record.match_points.count(10) != 2 || result.inject(:+) > 12
          record.errors[:base] << 'The result you have entered is a total
                                   bullshit; please re-evaluate it'
        end
      end
    end

    def validate_date_of_match_for(record)
      if record.played_on > Time.current
        record.errors[:base] << 'You can not submit a match from the future'
      end
    end

    def check_if_event_is_closed_for(record)
      if record.event && record.event.is_closed
        record.errors[:base] << 'Event was cosed; you can not submit any new
                                 matched to it'
      end
    end

    def check_if_event_is_rated_for(record)
      if record.event && record.event.is_rated
        record.errors[:base] << 'Event was already rated; you can not submit any
                                 new matches to it'
      end
    end
end
