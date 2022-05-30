class CreateParticipations < ActiveRecord::Migration[6.1]
  def change
    create_table :participations do |t|
      t.references :user
      t.references :ride

      t.timestamps
    end
  end
end
