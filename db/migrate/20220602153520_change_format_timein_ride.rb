class ChangeFormatTimeinRide < ActiveRecord::Migration[6.1]
  def change
    remove_column :rides, :starting_time, :datetime
    add_column :rides, :starting_time, :time
  end
end
