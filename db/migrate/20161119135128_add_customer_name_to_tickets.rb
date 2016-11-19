class AddCustomerNameToTickets < ActiveRecord::Migration[5.0]
  def change
    add_column :tickets, :customer_name, :string
    add_column :tickets, :customer_phone, :string
  end
end
