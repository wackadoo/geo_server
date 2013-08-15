class Fundamental::CharacterPositionsController < ApplicationController
  # GET /fundamental/character_positions
  # GET /fundamental/character_positions.json
  def index
    @fundamental_character_positions = Fundamental::CharacterPosition.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @fundamental_character_positions }
    end
  end

  # GET /fundamental/character_positions/1
  # GET /fundamental/character_positions/1.json
  def show
    @fundamental_character_position = Fundamental::CharacterPosition.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @fundamental_character_position }
    end
  end

  # GET /fundamental/character_positions/new
  # GET /fundamental/character_positions/new.json
  def new
    @fundamental_character_position = Fundamental::CharacterPosition.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @fundamental_character_position }
    end
  end

  # GET /fundamental/character_positions/1/edit
  def edit
    @fundamental_character_position = Fundamental::CharacterPosition.find(params[:id])
  end

  # POST /fundamental/character_positions
  # POST /fundamental/character_positions.json
  def create
    @fundamental_character_position = Fundamental::CharacterPosition.new(params[:fundamental_character_position])

    respond_to do |format|
      if @fundamental_character_position.save
        format.html { redirect_to @fundamental_character_position, notice: 'Character position was successfully created.' }
        format.json { render json: @fundamental_character_position, status: :created, location: @fundamental_character_position }
      else
        format.html { render action: "new" }
        format.json { render json: @fundamental_character_position.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /fundamental/character_positions/1
  # PUT /fundamental/character_positions/1.json
  def update
    @fundamental_character_position = Fundamental::CharacterPosition.find(params[:id])

    respond_to do |format|
      if @fundamental_character_position.update_attributes(params[:fundamental_character_position])
        format.html { redirect_to @fundamental_character_position, notice: 'Character position was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @fundamental_character_position.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /fundamental/character_positions/1
  # DELETE /fundamental/character_positions/1.json
  def destroy
    @fundamental_character_position = Fundamental::CharacterPosition.find(params[:id])
    @fundamental_character_position.destroy

    respond_to do |format|
      format.html { redirect_to fundamental_character_positions_url }
      format.json { head :ok }
    end
  end
end
