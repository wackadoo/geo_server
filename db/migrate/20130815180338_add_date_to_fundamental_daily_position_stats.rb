class AddDateToFundamentalDailyPositionStats < ActiveRecord::Migration
  def change
    add_column :fundamental_daily_position_stats, :day, :date
  end
end
