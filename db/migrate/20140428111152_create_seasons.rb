class CreateSeasons < ActiveRecord::Migration
  def change
    create_table :seasons do |t|
      t.string :name
      t.boolean :is_active, default: false

      t.timestamps
    end
  end
end
