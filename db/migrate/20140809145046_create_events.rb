class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.string :recurring_rule

      t.timestamps
    end
  end
end
