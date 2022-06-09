class AddMapUrlToRide < ActiveRecord::Migration[6.1]
  def change
    add_column :rides, :map_url, :string, default: ""
  end
end
