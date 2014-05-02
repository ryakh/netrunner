class Faction < ActiveRecord::Base
  has_many :identities
end
