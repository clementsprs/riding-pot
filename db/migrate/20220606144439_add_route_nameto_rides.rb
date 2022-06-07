class AddRouteNametoRides < ActiveRecord::Migration[6.1]
  def change
    add_column :rides, :route_name, :string
  end
end
