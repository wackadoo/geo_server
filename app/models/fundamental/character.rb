class Fundamental::Character < ActiveRecord::Base

  has_one  :position, :class_name => 'Fundamental::CharacterPosition',  :foreign_key => 'geo_character_id',  :inverse_of => :character

  IDENTIFIER_REGEX = /[a-z]{16}/i

  def self.find_by_id_or_identifier(user_identifier)
    identity = Fundamental::Character.find_by_id(user_identifier) if Fundamental::Character.valid_id?(user_identifier)
    identity = Fundamental::Character.find_by_identifier(user_identifier) if identity.nil? && Fundamental::Character.valid_identifier?(user_identifier)
    identity
  end

  def self.valid_identifier?(identifier)
    identifier.index(IDENTIFIER_REGEX) != nil
  end

  def self.valid_id?(id)
    id.index(/^[1-9]\d*$/) != nil
  end


end
