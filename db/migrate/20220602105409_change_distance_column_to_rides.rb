class ChangeDistanceColumnToRides < ActiveRecord::Migration[6.1]
  def change
    rename_column :rides, :distance, :distance_ride
  end
end
