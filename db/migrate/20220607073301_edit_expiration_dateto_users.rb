class EditExpirationDatetoUsers < ActiveRecord::Migration[6.1]
  def change
    change_column :users, :expires_at, :datetime
  end
end
