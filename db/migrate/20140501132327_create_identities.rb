class CreateIdentities < ActiveRecord::Migration
  def change
    create_table :identities do |t|
      t.string :name
      t.references :faction, index: true

      t.timestamps
    end
  end
end
