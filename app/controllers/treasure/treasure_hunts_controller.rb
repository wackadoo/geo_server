class Treasure::TreasureHuntsController < ApplicationController

  layout 'treasure'

  # GET /treasure/treasure_hunts
  # GET /treasure/treasure_hunts.json
  def index
    @treasure_treasure_hunts = Treasure::TreasureHunt.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @treasure_treasure_hunts }
    end
  end

  # GET /treasure/treasure_hunts/1
  # GET /treasure/treasure_hunts/1.json
  def show
    @treasure_treasure_hunt = Treasure::TreasureHunt.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @treasure_treasure_hunt }
    end
  end

  # GET /treasure/treasure_hunts/new
  # GET /treasure/treasure_hunts/new.json
  def new
    @treasure_treasure_hunt = Treasure::TreasureHunt.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @treasure_treasure_hunt }
    end
  end

  # GET /treasure/treasure_hunts/1/edit
  def edit
    @treasure_treasure_hunt = Treasure::TreasureHunt.find(params[:id])
  end

  # POST /treasure/treasure_hunts
  # POST /treasure/treasure_hunts.json
  def create
    @treasure_treasure_hunt = Treasure::TreasureHunt.new(params[:treasure_treasure_hunt])

    respond_to do |format|
      if @treasure_treasure_hunt.save
        format.html { redirect_to @treasure_treasure_hunt, notice: 'Treasure hunt was successfully created.' }
        format.json { render json: @treasure_treasure_hunt, status: :created, location: @treasure_treasure_hunt }
      else
        format.html { render action: "new" }
        format.json { render json: @treasure_treasure_hunt.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /treasure/treasure_hunts/1
  # PUT /treasure/treasure_hunts/1.json
  def update
    @treasure_treasure_hunt = Treasure::TreasureHunt.find(params[:id])

    respond_to do |format|
      if @treasure_treasure_hunt.update_attributes(params[:treasure_treasure_hunt])
        format.html { redirect_to @treasure_treasure_hunt, notice: 'Treasure hunt was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @treasure_treasure_hunt.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /treasure/treasure_hunts/1
  # DELETE /treasure/treasure_hunts/1.json
  def destroy
    @treasure_treasure_hunt = Treasure::TreasureHunt.find(params[:id])
    @treasure_treasure_hunt.destroy

    respond_to do |format|
      format.html { redirect_to treasure_treasure_hunts_url }
      format.json { head :ok }
    end
  end
end
