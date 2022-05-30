class CreateRides < ActiveRecord::Migration[6.1]
  def change
    create_table :rides do |t|
      t.float :distance
      t.string :title
      t.date :date
      t.date :starting_time
      t.string :starting_point
      t.text :description
      t.integer :elevation
      t.integer :pace_min
      t.integer :pace_max
      t.integer :attendees_max
      t.string :status
      t.string :gpx_file
      t.references :user

      t.timestamps
    end
  end
end
