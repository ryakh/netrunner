class Season < ActiveRecord::Base
  has_many :events
  has_many :standings, as: :rateable

  validates :name, presence: true

  def self.current
    Season.find_by(is_active: true)
  end

  def current_standings
    if is_active
      Event.first.standings
    else
      standings
    end
  end

  def self.is_running?
    !Season.current.nil?
  end

  def last_event_standings
    events.empty? ? [] : events.first.standings
  end

  def close
    Standing.generate_for_season(self)
    User.reset_ratings
    update_attribute(:is_active, false)
  end
end
