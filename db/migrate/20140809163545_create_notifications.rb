class CreateNotifications < ActiveRecord::Migration
  def change
    create_table :notifications do |t|
      t.integer :event_id
      t.integer :occurrence_id
      t.integer :user_id
      t.string :state
      t.text :comment

      t.timestamps
    end
  end
end
