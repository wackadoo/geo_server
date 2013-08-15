class Character::GeoPositionsController < ApplicationController
  # GET /character/geo_positions
  # GET /character/geo_positions.json
  def index
    @character_geo_positions = Character::GeoPosition.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @character_geo_positions }
    end
  end

  # GET /character/geo_positions/1
  # GET /character/geo_positions/1.json
  def show
    @character_geo_position = Character::GeoPosition.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @character_geo_position }
    end
  end

  # GET /character/geo_positions/new
  # GET /character/geo_positions/new.json
  def new
    @character_geo_position = Character::GeoPosition.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @character_geo_position }
    end
  end

  # GET /character/geo_positions/1/edit
  def edit
    @character_geo_position = Character::GeoPosition.find(params[:id])
  end

  # POST /character/geo_positions
  # POST /character/geo_positions.json
  def create
    @character_geo_position = Character::GeoPosition.new(params[:character_geo_position])

    respond_to do |format|
      if @character_geo_position.save
        format.html { redirect_to @character_geo_position, notice: 'Geo position was successfully created.' }
        format.json { render json: @character_geo_position, status: :created, location: @character_geo_position }
      else
        format.html { render action: "new" }
        format.json { render json: @character_geo_position.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /character/geo_positions/1
  # PUT /character/geo_positions/1.json
  def update
    @character_geo_position = Character::GeoPosition.find(params[:id])

    respond_to do |format|
      if @character_geo_position.update_attributes(params[:character_geo_position])
        format.html { redirect_to @character_geo_position, notice: 'Geo position was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @character_geo_position.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /character/geo_positions/1
  # DELETE /character/geo_positions/1.json
  def destroy
    @character_geo_position = Character::GeoPosition.find(params[:id])
    @character_geo_position.destroy

    respond_to do |format|
      format.html { redirect_to character_geo_positions_url }
      format.json { head :ok }
    end
  end
end
