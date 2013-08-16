class CreateFundamentalDailyPositionStats < ActiveRecord::Migration
  def change
    create_table :fundamental_daily_position_stats do |t|
      t.integer :geo_character_id
      t.decimal :distance,    :null => false, :default => 0.0
      t.integer :reports,     :null => false, :default => 0
      t.integer :max_vel,     :null => false, :default => 0
      t.boolean :geo_enabled
      t.boolean :suspect,     :null => false, :default =>false

      t.timestamps
    end
  end
end
