class Identity < ActiveRecord::Base
  belongs_to :faction

  def self.corporations
    Identity.where(
      faction_id: Faction.where(is_corporation: true).pluck(:id)
    )
  end

  def self.runners
    Identity.where(
      faction_id: Faction.where(is_runner: true).pluck(:id)
    )
  end
end
