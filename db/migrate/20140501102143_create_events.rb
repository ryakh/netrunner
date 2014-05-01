class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.datetime :started
      t.datetime :finished
      t.boolean :is_closed, default: false
      t.boolean :is_rated,  default: false

      t.timestamps
    end
  end
end
