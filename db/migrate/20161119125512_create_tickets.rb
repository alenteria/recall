class CreateTickets < ActiveRecord::Migration[5.0]
  def change
    create_table :tickets do |t|
      t.belongs_to :agent
      t.string :title
      t.text :description
      t.attachment :image
      t.timestamps null: false
    end
  end
end
