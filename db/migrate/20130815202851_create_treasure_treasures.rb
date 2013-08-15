class CreateTreasureTreasures < ActiveRecord::Migration
  def change
    create_table :treasure_treasures do |t|
      t.integer :category
      t.integer :level,        :null => false, :default => 0
      t.decimal :latitude
      t.decimal :longitutde
      t.integer :difficulty,   :null => false, :default => 0

      t.timestamps
    end
  end
end
