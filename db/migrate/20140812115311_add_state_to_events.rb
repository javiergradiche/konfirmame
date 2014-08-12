class AddStateToEvents < ActiveRecord::Migration
  def change
    add_column :events, :state, :string, :default => 'active'
  end
end
