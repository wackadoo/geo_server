class Fundamental::CharacterPosition < ActiveRecord::Base

  belongs_to  :character,  :class_name => 'Fundamental::Character',  :foreign_key => 'geo_character_id',  :inverse_of => :position

end
