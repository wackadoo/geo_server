class Fundamental::Character < ActiveRecord::Base

  has_one  :position, :class_name => 'Fundamental::CharacterPosition',  :foreign_key => 'geo_character_id',  :inverse_of => :character

end
