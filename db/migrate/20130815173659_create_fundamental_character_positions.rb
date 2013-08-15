class CreateFundamentalCharacterPositions < ActiveRecord::Migration
  def change
    create_table :fundamental_character_positions do |t|
      
      t.integer  :geo_character_id
      t.decimal  :longitude
      t.decimal  :latitude
      t.integer  :delta,   :null => false, :default => 0
      t.boolean  :suspect, :null => false, :default => false
      t.string   :remote_ip

      t.timestamps
    end
  end
end
