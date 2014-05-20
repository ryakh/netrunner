class Match < ActiveRecord::Base
  include ActiveModel::Validations

  validates :first_player,
    :second_player,
    :first_player_corporation_points,
    :first_player_runner_points,
    :second_player_corporation_points,
    :second_player_runner_points, presence: true

  validates_with MatchValidator

  belongs_to :first_player,              class_name: 'User'
  belongs_to :second_player,             class_name: 'User'

  belongs_to :first_player_corporation,  class_name: 'Identity'
  belongs_to :first_player_runner,       class_name: 'Identity'
  belongs_to :second_player_corporation, class_name: 'Identity'
  belongs_to :second_player_runner,      class_name: 'Identity'

  belongs_to :event

  before_create :set_event, :calculate_league_points

  def match_points
    [
      first_player_corporation_points,
      first_player_runner_points,
      second_player_corporation_points,
      second_player_runner_points
    ]
  end

  def match_summary
    summary = []

    match_points.in_groups(2).each do |result|
      summary << result.inject(:+)
    end

    return summary
  end

  private
    def set_event
      self.event = Event.current
    end

    def calculate_league_points
      league_points = []
      result_comparation = match_summary[0] <=> match_summary[1]

      case result_comparation
      when 0
        league_points = [3, 3]
      when 1
        league_points = first_player_modified_win
      when -1
        league_points = second_player_modified_win
      end

      self.first_player_league_points = league_points.first
      self.second_player_league_points = league_points.last
    end

  protected
    def first_player_modified_win
      if match_summary.include?(20)
        [6, 0]
      else
        [4, 2]
      end
    end

    def second_player_modified_win
      if match_summary.include?(20)
        [0, 6]
      else
        [2, 4]
      end
    end
end
