class AddCategoryToTickets < ActiveRecord::Migration[5.0]
  def change
    add_column :tickets, :category, :string
  end
end
