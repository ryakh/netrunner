class Season < ActiveRecord::Base
  has_many :events

  validates :name, presence: true

  def self.current
    Season.find_by(is_active: true)
  end

  def self.is_running?
    !Season.current.nil?
  end
end
