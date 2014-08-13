class AddRushStartToEvents < ActiveRecord::Migration
  def change
    add_column :events, :rush_start, :integer
  end
end
