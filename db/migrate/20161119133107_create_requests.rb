class CreateRequests < ActiveRecord::Migration[5.0]
  def change
    create_table :requests do |t|
      t.string :name
      t.string :phone
      t.string :status
      t.belongs_to :agent
    end
  end
end
