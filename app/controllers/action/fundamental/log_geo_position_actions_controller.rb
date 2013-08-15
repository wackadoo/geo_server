class Action::Fundamental::LogGeoPositionActionsController < ApplicationController
  layout 'action'

  before_filter :authenticate

  def create
    raise BadRequestError.new('no current character') if current_character.nil?

    if params[:log_geo_position_action].nil? ||
        params[:log_geo_position_action][:longitude].blank? ||
        params[:log_geo_position_action][:latitude].blank?
      raise BadRequestError.new('missing params')
    end

    current_character.longitude = params[:log_geo_position_action][:longitude]
    current_character.latitude =  params[:log_geo_position_action][:latitude]
    current_character.location_updated_at = Time.now
    current_character.save

    position = current_character.position
    position = current_character.build_position if position.nil?
    position.longitude = params[:log_geo_position_action][:longitude]
    position.latitude =  params[:log_geo_position_action][:latitude]
    position.save

    respond_to do |format|
      format.json { render json: {}, status: :ok }
    end
  end
  
end
