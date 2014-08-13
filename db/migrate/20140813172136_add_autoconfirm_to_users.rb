class AddAutoconfirmToUsers < ActiveRecord::Migration
  def change
    add_column :users, :autoconfirm, :boolean, :default => false
  end
end
