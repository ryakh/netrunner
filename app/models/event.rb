class Event < ActiveRecord::Base
  belongs_to :season

  has_many :matches

  def self.current
    Event.find_by(is_closed: false)
  end

  def self.create_current
    Event.create(
      started_at:  Time.now.beginning_of_week,
      finished_at: Time.now.end_of_week,
      season:      Season.find_by(is_active: true)
    )
  end
end
