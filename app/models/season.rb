class Season < ActiveRecord::Base
  has_many :events
  has_many :standings, as: :rateable

  validates :name, presence: true

  def self.current
    Season.find_by(is_active: true)
  end

  def self.is_running?
    !Season.current.nil?
  end

  def active_users
    active_users = Standing.where(rateable: self.events).pluck(:user_id).uniq
    User.where(id: active_users).order('rating DESC')
  end

  def last_event_standings
    events.last.standings
  end

  def generate_standings
    Standing.generate_for_season(self)
  end
end
