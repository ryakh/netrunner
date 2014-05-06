class Match < ActiveRecord::Base
  belongs_to :first_player,              class_name: 'User'
  belongs_to :second_player,             class_name: 'User'

  belongs_to :first_player_corporation,  class_name: 'Identity'
  belongs_to :first_player_runner,       class_name: 'Identity'
  belongs_to :second_player_corporation, class_name: 'Identity'
  belongs_to :second_player_runner,      class_name: 'Identity'

  before_create :create_new_event, if: :no_active_event?

  private
    def create_new_event
      Event.create(
        started_at:  DateTime.now.beginning_of_week,
        finished_at: DateTime.now.end_of_week
      )
    end

    def no_active_event?
      if Event.find_by(is_closed: false).nil?
        return true
      end
    end
end
