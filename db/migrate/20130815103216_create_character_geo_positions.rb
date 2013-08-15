class CreateCharacterGeoPositions < ActiveRecord::Migration
  def change
    create_table :character_geo_positions do |t|
      t.integer :character_id
      t.float :latitude
      t.float :longitude

      t.timestamps
    end
  end
end
