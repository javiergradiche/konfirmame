class RenameOccurrenceIdToEventOccurrenceIdToNotifications < ActiveRecord::Migration
  def change
  	rename_column :notifications, :occurrence_id, :event_occurrence_id
  end
end
