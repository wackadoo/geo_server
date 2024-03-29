class Fundamental::Character < ActiveRecord::Base

  has_one  :position, :class_name => 'Fundamental::CharacterPosition',  :foreign_key => 'geo_character_id',  :inverse_of => :character

  IDENTIFIER_REGEX = /[a-z]{16}/i

  scope :with_lat_and_long, where('latitude is not null and longitude is not null')
  scope :recently_updated,  where('location_updated_at is not null and location_updated_at > ?', Time.now - GEO_SERVER_CONFIG['recently_updated_interval'].minutes)

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
