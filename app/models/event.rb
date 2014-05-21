class Event < ActiveRecord::Base
  belongs_to :season

  has_many :matches
  has_many :standings, as: :rateable

  before_create :set_season, if: Proc.new { |e| Season.is_running? }

  default_scope { order('finished_at DESC') }

  def self.weekly_setup
    if Season.is_running?
      finish_date = Event.current.finished_at

      close_current_week
      start_new_week(finish_date)
    end
  end

  def calculate
    unless is_rated
      Standing.generate_for_event(self)
      update_attribute(:is_rated, true)
    end
  end

  def self.is_running?
    !Event.current.nil?
  end

  def self.current
    Event.find_by(is_closed: false)
  end

  def self.create_current
    if Season.is_running?
      Event.create(
        started_at:  Time.current.beginning_of_week,
        finished_at: Time.current.end_of_week
      )
    end
  end

  private
    def self.close_current_week
      if Event.matches.length.eql?(0)
        Event.current.destroy
      else
        Event.current.update_attribute(:is_closed, true)
      end
    end

    def self.start_new_week(previous_week)
      Event.create(
        started_at:  previous_week.next_week.beginning_of_week,
        finished_at: previous_week.next_week.end_of_week
      )
    end

    def set_season
      self.season = Season.current
    end
end
