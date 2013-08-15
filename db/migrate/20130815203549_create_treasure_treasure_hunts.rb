class CreateTreasureTreasureHunts < ActiveRecord::Migration
  def change
    create_table :treasure_treasure_hunts do |t|
      t.integer :category
      t.integer :level,           :null => false, :default => 0
      t.decimal :latitude
      t.decimal :longitutde
      t.integer :difficulty,      :null => false, :default => false
      t.integer :geo_character_id
      t.integer :distance
      t.boolean :success,         :null => false, :default => false
      t.integer :treasure_id
      t.timestamps
    end
  end
end
