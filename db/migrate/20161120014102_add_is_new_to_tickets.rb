class AddIsNewToTickets < ActiveRecord::Migration[5.0]
  def change
    add_column :tickets, :is_new, :boolean
  end
end
