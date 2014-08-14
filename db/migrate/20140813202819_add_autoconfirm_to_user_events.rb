class AddAutoconfirmToUserEvents < ActiveRecord::Migration
  def change
    add_column :user_events, :autoconfirm, :boolean
  end
end
