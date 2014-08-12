class CreateOccurrences < ActiveRecord::Migration
  def change
    create_table :occurrences do |t|
      t.integer :event_id
      t.datetime :start_datetime
      t.string :state
      t.integer :aforo
      t.integer :num_confirm

      t.timestamps
    end
  end
end
