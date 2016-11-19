class CreateTicketLogs < ActiveRecord::Migration[5.0]
  def change
    create_table :ticket_logs do |t|
      t.string :action
      t.text :content
      t.belongs_to :ticket
      t.belongs_to :agent
      t.timestamps
    end
  end
end
