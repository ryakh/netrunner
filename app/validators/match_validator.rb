class MatchValidator < ActiveModel::Validator
  def validate(record)
    validate_match_summary(record)
    validate_players(record)
    validate_score(record)
    validate_date_of_match(record)
    check_if_event_is_closed(record)
  end

  private
    def validate_match_summary(record)
      unless record.match_points.include?(nil)
        summary = record.match_points.inject(:+)

        if summary > 32 || summary < 20
          record.errors[:base] << 'Sum of match points can not exceed 32
                                   or be less than 20'
        end
      end
    end

    def validate_players(record)
      unless record.first_player.nil? || record.second_player_id.nil?
        if record.first_player_id == record.second_player_id
          record.errors[:base] << 'You can not play with yourself, DOH!'
        end
      end
    end

    def validate_score(record)
      unless record.match_points.include?(nil)
        result = record.match_points
        result.delete(10)

        if record.match_points.count(10) != 2 || result.inject(:+) > 12 || score_invalid?(record.match_points)
          record.errors[:base] << 'The result you have entered is a total
                                   bullshit; please re-evaluate it'
        end
      end
    end

    def validate_date_of_match(record)
      if record.played_on > Time.current
        record.errors[:base] << 'You can not submit a match from the future'
      end
    end

    def check_if_event_is_closed(record)
      if record.event && record.event.is_closed
        record.errors[:base] << 'Event was cosed; you can not submit any new
                                 matched to it'
      end
    end

  protected
    def score_invalid?(result)
      winning_pairs = result.each_index.select{ |i| result[i] == 10 }

      if winning_pairs == [0,3] || winning_pairs == [1,2]
        return true
      else
        return false
      end
    end
end
