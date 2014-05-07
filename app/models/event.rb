class Event < ActiveRecord::Base
  belongs_to :season

  has_many :matches

  def self.current
    Event.find_by(is_closed: false)
  end
end
