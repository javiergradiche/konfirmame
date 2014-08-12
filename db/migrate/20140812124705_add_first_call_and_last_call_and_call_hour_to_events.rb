class AddFirstCallAndLastCallAndCallHourToEvents < ActiveRecord::Migration
  def change
    add_column :events, :first_call, :integer
    add_column :events, :last_call, :integer
    add_column :events, :call_hour, :integer
  end
end
