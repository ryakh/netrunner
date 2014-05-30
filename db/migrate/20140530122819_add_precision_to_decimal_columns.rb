class AddPrecisionToDecimalColumns < ActiveRecord::Migration
  def change
    change_column :standings, :rating,     :decimal, precision: 11, scale: 11
    change_column :standings, :deviation,  :decimal, precision: 11, scale: 11
    change_column :standings, :volatility, :decimal, precision: 11, scale: 11

    remove_column :users, :rating
    remove_column :users, :deviation
    remove_column :users, :volatility

    add_column :users, :rating,     :decimal, precision: 11, scale: 11
    add_column :users, :deviation,  :decimal, precision: 11, scale: 11
    add_column :users, :volatility, :decimal, precision: 11, scale: 11
  end
end
