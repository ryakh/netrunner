class Event < ActiveRecord::Base
  belongs_to :season

  has_many :matches
end
