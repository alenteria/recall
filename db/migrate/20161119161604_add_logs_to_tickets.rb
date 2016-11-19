class AddLogsToTickets < ActiveRecord::Migration[5.0]
  def change
    add_column :tickets, :logs, :text
  end
end
