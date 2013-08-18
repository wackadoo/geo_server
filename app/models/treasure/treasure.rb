require 'Util/Formula'

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
  
    if count_near < 1           # at least two treasures in close range
      (1-count_near).times do
        Treasure::Treasure.place_treasure_in_range_of(latitude, longitude, 0.003, 2) 
        count_all += 1
      end
    end
  
    if count_all < 10           # at least 15 treasures in long range
      (10-count_all).times do
        Treasure::Treasure.place_treasure_in_range_of(latitude, longitude, 0.03, 10) 
      end
    end

    treasures = Treasure::Treasure.find_in_range_of(latitude, longitude)        
  end
  
  def self.place_treasure_in_range_of(latitude, longitude, range, max_level)
    treasure_type = Treasure::Treasure.random_treasure_type

    max = 10
    level_mass = ((max+1)*max) / 2.0   # p(level=1) = max, p(l=2) = max-1,  p(max) = 1  where p is the probability weight (not normalized)
    
    x = rand(level_mass)
    
    level = 1
    (1..max).each do |v|
      if x >= 0
        level = v
      end
      x -= max-(v-1);
    end
    
    difficulty = Util::Formula.parse_from_formula(treasure_type[:difficulty]).apply(level)

    treasure = Treasure::Treasure.create({
      level:         level,
      category:      treasure_type[:id],
      difficulty:    difficulty,
      
      latitude:      latitude + (2*rand()-1) * range,
      longitude:     longitude + (2*rand()-1) * range,
    })
  end
  
  # draws a random treasure from the list of all treasure types
  # using the probabiltity factors to determine the selection
  # probability of each individual type.
  def self.random_treasure_type
    treasure_types = GameRules::Rules.the_rules.treasure_types
  
    p_mass   = 0
    treasure_types.each { |treasure| p_mass += treasure[:probability_factor].to_i }
    treasure = nil
    random_number = rand(p_mass)
    
    treasure_types.each do |t|
      if random_number >= 0
        treasure = t
      end
      random_number -= t[:probability_factor]
    end
    
    treasure
  end
  
end
