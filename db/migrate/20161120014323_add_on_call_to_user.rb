class AddOnCallToUser < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :on_call, :boolean
  end
end
