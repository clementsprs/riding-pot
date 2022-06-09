class AddParticipantsToRides < ActiveRecord::Migration[6.1]
  def change
    add_column :rides, :participants, :integer, default: 1
  end
end
