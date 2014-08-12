class AddEndDatetimeAndLastShippingRushStartToNotifications < ActiveRecord::Migration
  def change
    add_column :notifications, :end_datetime, :datetime
    add_column :notifications, :last_shipping, :datetime
    add_column :notifications, :rush_start, :datetime
  end
end
