class Action::Treasure::OpenTreasureActionsController < ApplicationController
  layout 'action'

  before_filter :authenticate

  def create
    raise BadRequestError.new('no treasure id sent')  if params[:id].blank?
    raise BadRequestError.new('no character id sent') if params[:identifier].blank?
    
    @character = Fundamental::Character.find_by_identifier(params[:identifier])
    
    raise BadRequestError.new('no character') unless @character
    raise BadRequestError.new('no position for character') if @character.latitude.nil? || @character.longitude.nil?
    
    @treasure = Treasure::Treasure.find_by_id(params[:id])
    raise NotFoundError.new('Treasure Not Found') if @treasure.nil?

    radius_earth = 6371                      # in km
    
    distance = Mapping::Util.map_distance(@character.latitude, @character.longitude, @treasure.latitude, @treasure.longitude)
                             
    logger.debug "trying to grab treasure #{ @treasure.id } in #{ distance }km distance of character #{ @character.name }" 
                         
    if distance < 0.2  # 200 m distance is ok
      @treasure.destroy
      head :ok
    else 
      head :forbidden
    end
  end
  
end
