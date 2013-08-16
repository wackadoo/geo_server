class CreateFundamentalCharacters < ActiveRecord::Migration
  def change
    create_table :fundamental_characters do |t|
      t.integer :character_id
      t.string :identifier
      t.boolean :deleted,              :null => false, :default => false
      t.decimal :longitude
      t.decimal :latitude
      t.datetime :location_updated_at
      t.decimal :distance_today,  :null => false, :default => 0.0
      t.decimal :distance_total,  :null => false, :default => 0.0
      t.datetime :premium_ended_at
      t.decimal  :longitude_bias, :null => false, :default => 0.0
      t.decimal  :latitude_bias,  :null => false, :default => 0.0
      t.boolean  :bias_enabled,   :null => false, :default => true
      t.integer  :privacy_mode,   :null => false, :default => 5      # ally_visible = 5 , 0 = public to all (no privacy), 7 = friends
      t.boolean  :geo_enabled,    :null => false, :default => true   # it's opt out (after answering "yes" on the phone to the system-check)
      t.datetime :geo_setting_changed_at
      t.timestamps
    end
  end
end
