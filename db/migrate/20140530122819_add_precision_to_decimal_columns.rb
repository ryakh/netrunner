class AddPrecisionToDecimalColumns < ActiveRecord::Migration
  def change
    change_column :standings, :rating,     :decimal, precision: 5, scale: 11
    change_column :standings, :deviation,  :decimal, precision: 5, scale: 11
    change_column :standings, :volatility, :decimal, precision: 5, scale: 11

    change_column :users, :rating,     :decimal, precision: 5, scale: 11
    change_column :users, :deviation,  :decimal, precision: 5, scale: 11
    change_column :users, :volatility, :decimal, precision: 5, scale: 11
  end
end
