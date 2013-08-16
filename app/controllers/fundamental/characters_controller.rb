class Fundamental::CharactersController < ApplicationController
  layout 'fundamental'

  before_filter :authenticate, :except => [:show, :index, :self]
  before_filter :deny_api,     :except => [:show, :index, :self]

  # GET /fundamental/characters
  # GET /fundamental/characters.json
  def index
    
    @fundamental_characters = nil
    
    if (params.has_key?(:longitude) && params.has_key?(:latitude) && !params.has_key?(:range) && params.has_key?(:n)) 
       
       longitude = params[:longitude].to_f
       latitude = params[:latitude].to_f
       num = params[:n].to_i
       logger.debug("longitude=#{longitude}, latitude=#{latitude}, n=#{num}")
       #TODO check for radian/grad range
       raise BadRequestError.new('longitude or langitude had the wrong format') if longitude.nan?
       raise BadRequestError.new('langitude had the wrong format') if latitude.nan?
       raise BadRequestError.new('n had the wrong format') if num <= 0
       #TODO exchange with real calc (with cos)
       whereStr = "(latitude IS NOT NULL) AND (longitude IS NOT NULL)"
       whereHash = Hash.new
       #if !current_character.nil?
       #   whereStr += " AND user_id != :userid"
       #  whereHash[:userid] = current_user.id;
       #end
       @fundamental_characters = Fundamental::Character.where(whereStr, whereHash).order("(((longitude- #{longitude})*(longitude- #{longitude})) + ((latitude- #{latitude})*(latitude- #{latitude}))) ASC").limit(num);
    
     elsif (params.has_key?(:longitude) && params.has_key?(:latitude) && params.has_key?(:range)) 
    
       longitude = params[:longitude].to_f
       latitude = params[:latitude].to_f
       range = params[:range].to_f
       raise BadRequestError.new('longitude or langitude had the wrong format') if longitude.nan? || latitude.nan?
       raise BadRequestError.new('range had the wrong format') if range <= 0.0
       whereStr = "(latitude IS NOT NULL) AND (longitude IS NOT NULL) AND (((longitude- :longitude)*(longitude- :longitude)) + ((latitude- :latitude)*(latitude- :latitude))) <= (:range * :range)"
       whereHash = {:latitude => latitude, :longitude => longitude, :range => range}
       # if !current_user.nil?
       #   whereStr += " AND user_id != :userid"
       #   whereHash[:userid] = current_user.id;
       # end
       @fundamental_characters = Fundamental::Character.where(whereStr, whereHash)
       
     elsif (params.has_key?(:longitude) || params.has_key?(:latitude) || params.has_key?(:range) || params.has_key?(:n))
     
       raise BadRequestError.new('missing longitude') unless params.has_key?(:longitude)
       raise BadRequestError.new('missing langitude') unless params.has_key?(:latitude) 
       raise BadRequestError.new('missing n or range')
     
     elsif !current_character.nil?
       
        longitude = current_character.longitude
        latitude  = current_character.latitude
        num       = 10
        raise BadRequestError.new('longitude or langitude had the wrong format') if longitude.nan?
        raise BadRequestError.new('langitude had the wrong format') if latitude.nan?
        raise BadRequestError.new('n had the wrong format') if num <= 0
        #TODO exchange with real calc (with cos)
        whereStr = "(latitude IS NOT NULL) AND (longitude IS NOT NULL)"
        whereHash = Hash.new
        #if !current_character.nil?
        #   whereStr += " AND user_id != :userid"
        #  whereHash[:userid] = current_user.id;
        #end
        @fundamental_characters = Fundamental::Character.where(whereStr, whereHash).order("(((longitude- #{longitude})*(longitude- #{longitude})) + ((latitude- #{latitude})*(latitude- #{latitude}))) ASC").limit(num);
       
     else
       @fundamental_characters = Fundamental::Character.all
     end

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @fundamental_characters }
    end
  end

  # GET /fundamental/characters/1
  # GET /fundamental/characters/1.json
  def show
    @fundamental_character = Fundamental::Character.find_by_id_or_identifier(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @fundamental_character }
    end
  end

  # GET /fundamental/characters/1
  # GET /fundamental/characters/1.json
  def self
    @fundamental_character = current_character

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @fundamental_character }
    end
  end


  # GET /fundamental/characters/new
  # GET /fundamental/characters/new.json
  def new
    @fundamental_character = Fundamental::Character.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @fundamental_character }
    end
  end

  # GET /fundamental/characters/1/edit
  def edit
    @fundamental_character = Fundamental::Character.find(params[:id])
  end

  # POST /fundamental/characters
  # POST /fundamental/characters.json
  def create
    @fundamental_character = Fundamental::Character.new(params[:fundamental_character])

    respond_to do |format|
      if @fundamental_character.save
        format.html { redirect_to @fundamental_character, notice: 'Character was successfully created.' }
        format.json { render json: @fundamental_character, status: :created, location: @fundamental_character }
      else
        format.html { render action: "new" }
        format.json { render json: @fundamental_character.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /fundamental/characters/1
  # PUT /fundamental/characters/1.json
  def update
    @fundamental_character = Fundamental::Character.find(params[:id])

    respond_to do |format|
      if @fundamental_character.update_attributes(params[:fundamental_character])
        format.html { redirect_to @fundamental_character, notice: 'Character was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @fundamental_character.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /fundamental/characters/1
  # DELETE /fundamental/characters/1.json
  def destroy
    @fundamental_character = Fundamental::Character.find(params[:id])
    @fundamental_character.destroy

    respond_to do |format|
      format.html { redirect_to fundamental_characters_url }
      format.json { head :ok }
    end
  end
end
