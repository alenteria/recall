class AddAvailabilityToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :availability, :string
  end
end
