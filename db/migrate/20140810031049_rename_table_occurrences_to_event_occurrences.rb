class RenameTableOccurrencesToEventOccurrences < ActiveRecord::Migration
  def change
    rename_table :occurrences, :event_occurrences
  end
end
