class AddCityToRide < ActiveRecord::Migration[6.1]
  def change
    add_column :rides, :city, :string, default: ""
  end
end
