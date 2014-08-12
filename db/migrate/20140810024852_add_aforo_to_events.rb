class AddAforoToEvents < ActiveRecord::Migration
  def change
    add_column :events, :aforo, :integer
  end
end
