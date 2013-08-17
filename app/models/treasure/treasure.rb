class Treasure::Treasure < ActiveRecord::Base
  
  scope :placed,      where('(latitude IS NOT NULL) AND (longitude IS NOT NULL)')
  scope :in_range_of, lambda { | lat, long, range | where(['latitude > ?) AND (latitude < ?) AND (longitude > ?) AND (longitude < ?', lat-range, lat+range, long-range, long+range]) }
  
  def self.find_in_range_of(latitude, longitude)
    km10 = 0.03   # TODO: replace this by a calculation of the degrees that correspond to 10km at the given location (due to the projection, it depends on position on earth)
    Treasure::Treasure.placed.in_range_of(latitude, longitude, km10)
  end
  
  def self.find_or_create_in_range_of(latitude, longitude)
    treasures = Treasure::Treasure.find_in_range_of(latitude, longitude)
  
    count_near = 0
    count_all = 0
  
    treasures.each do | tr |
      #distance = Mapping::map_distance latitude, longitude, tr.latitude, tr.longitude
      #logger.debug("distance #{ distance }")
      if (tr.latitude-latitude).abs < 0.003 && (tr.longitude-longitude).abs < 0.005    #distance <= 0.01
        count_near += 1
      end
      count_all += 1
    end
  
    if count_near < 2           # at least two treasures in close range
      (2-count_near).times do
        Treasure::Treasure.place_treasure_in_range_of(latitude, longitude, 0.003) 
        count_all += 1
      end
    end
  
    if count_all < 15           # at least 15 treasures in long range
      (15-count_all).times do
        Treasure::Treasure.place_treasure_in_range_of(latitude, longitude, 0.03) 
      end
    end

    treasures = Treasure::Treasure.find_in_range_of(latitude, longitude)        
  end
  
  def self.place_treasure_in_range_of(latitude, longitude, range)
    treasure = Treasure::Treasure.create({
      level:         rand(1..10),
      category:      rand(1..3),
      difficulty:    rand(1..100),
      latitude:      latitude + (2*rand()-1) * range,
      longitude:     longitude + (2*rand()-1) * range,
    })
  end
  
end
