class Action::Fundamental::LogGeoPositionActionsController < ApplicationController
  layout 'action'

  #before_filter :authenticate

  def create
    #raise BadRequestError.new('no current character') if current_character.nil?
    if params[:log_geo_position_action].nil? ||
        params[:log_geo_position_action][:longitude].blank? ||
        params[:log_geo_position_action][:latitude].blank? ||
        params[:log_geo_position_action][:character_id].blank?
      raise BadRequestError.new('missing params')
    end

    geo_position = Fundamental::Character.find_or_initialize_by_character_id(params[:log_geo_position_action][:character_id])
    geo_position.longitude = params[:log_geo_position_action][:longitude]
    geo_position.latitude =  params[:log_geo_position_action][:latitude]
    geo_position.location_updated_at = Time.now
    geo_position.save

    respond_to do |format|
      format.json { render json: {}, status: :ok }
    end
  end
  
end
