class AddEventReferenceToMatches < ActiveRecord::Migration
  def change
    add_reference :matches, :event, index: true
  end
end
