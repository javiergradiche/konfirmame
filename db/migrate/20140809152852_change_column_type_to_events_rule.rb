class ChangeColumnTypeToEventsRule < ActiveRecord::Migration
  def change
    change_column :events, :recurring_rule, :text
  end
end
