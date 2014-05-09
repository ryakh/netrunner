class MatchPointsValidator < ActiveModel::Validator
  def validate(record)
    validate_match_summary_for(record)
    validate_players(record)
    validate_score(record)
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

        if record.match_points.count(10) != 2 || result.inject(:+) > 12
          record.errors[:base] << 'The result you have entered is a total
                                   bullshit; please re-evaluate it'
        end
      end
    end
end
