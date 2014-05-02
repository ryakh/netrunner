class RenameDatesOnEvent < ActiveRecord::Migration
  def change
    rename_column :events, :started,  :started_at
    rename_column :events, :finished, :finished_at
  end
end
