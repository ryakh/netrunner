class CreateStandings < ActiveRecord::Migration
  def change
    create_table :standings do |t|
      t.references :rateable, polymorphic: true, index: true
      t.references :user, index: true
      t.decimal    :rating
      t.decimal    :deviation
      t.decimal    :volatility

      t.timestamps
    end
  end
end
