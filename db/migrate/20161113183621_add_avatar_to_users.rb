class AddAvatarToUsers < ActiveRecord::Migration[5.0]
  def up
    add_column :users, :provider, :string
    add_column :users, :uid, :string
    add_attachment :users, :avatar
  end

  def down
    remove_attachment :users, :avatar
    remove_column :users, :provider, :string
    remove_column :users, :uid, :string
  end
end
