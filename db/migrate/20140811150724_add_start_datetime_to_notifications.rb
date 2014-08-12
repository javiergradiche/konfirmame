class AddStartDatetimeToNotifications < ActiveRecord::Migration
  def change
    add_column :notifications, :start_datetime, :datetime
  end
end
