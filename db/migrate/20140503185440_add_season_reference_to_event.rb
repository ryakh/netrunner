class AddSeasonReferenceToEvent < ActiveRecord::Migration
  def change
    add_reference :events, :season, index: true
  end
end
