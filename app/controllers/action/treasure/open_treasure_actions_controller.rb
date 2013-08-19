require 'mapping/util'

class Action::Treasure::OpenTreasureActionsController < ApplicationController
  layout 'action'

  before_filter :authenticate

  def create
    raise BadRequestError.new('no current character') if current_character.nil?
    raise BadRequestError.new('no treasure id sent')  if params[:open_treasure_action].nil? || params[:open_treasure_action][:id].nil?
    raise BadRequestError.new('no position for character') if current_character.latitude.nil? || current_character.longitude.nil?
    
    @treasure = Treasure::Treasure.find_by_id(params[:open_treasure_action][:id])
    raise NotFoundError.new('Treasure Not Found') if @treasure.nil?

    logger.debug "#{current_character.latitude} #{current_character.longitude} #{@treasure.latitude} #{@treasure.longitude} "

    distance = Mapping::Util.map_distance(current_character.latitude, current_character.longitude, @treasure.latitude, @treasure.longitude)
                             
    logger.debug "trying to grab treasure #{ @treasure.id } in #{ distance }km distance of character #{ current_character.identifier }"
                         
    if distance < -0.2  # 200 m distance is ok
      @treasure.destroy
      head :ok
    else 
      head :forbidden
    end
  end
  
end
