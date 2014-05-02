class CreateFactions < ActiveRecord::Migration
  def change
    create_table :factions do |t|
      t.string  :name
      t.boolean :is_runner,      default: false
      t.boolean :is_corporation, default: false

      t.timestamps
    end
  end
end
