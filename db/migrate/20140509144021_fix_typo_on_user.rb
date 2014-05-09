class FixTypoOnUser < ActiveRecord::Migration
  def change
    rename_column :users, :volatality, :volatility
  end
end
