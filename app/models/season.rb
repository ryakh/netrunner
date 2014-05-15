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

  def standings
    active_users = Standing.where(rateable: events).pluck(:user_id)
    User.where(id: active_users).order('rating DESC')
  end
end
