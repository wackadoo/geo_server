class Fundamental::DailyPositionStatsController < ApplicationController
  
  layout 'fundamental'
  
  # GET /fundamental/daily_position_stats
  # GET /fundamental/daily_position_stats.json
  def index
    @fundamental_daily_position_stats = Fundamental::DailyPositionStat.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @fundamental_daily_position_stats }
    end
  end

  # GET /fundamental/daily_position_stats/1
  # GET /fundamental/daily_position_stats/1.json
  def show
    @fundamental_daily_position_stat = Fundamental::DailyPositionStat.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @fundamental_daily_position_stat }
    end
  end

  # GET /fundamental/daily_position_stats/new
  # GET /fundamental/daily_position_stats/new.json
  def new
    @fundamental_daily_position_stat = Fundamental::DailyPositionStat.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @fundamental_daily_position_stat }
    end
  end

  # GET /fundamental/daily_position_stats/1/edit
  def edit
    @fundamental_daily_position_stat = Fundamental::DailyPositionStat.find(params[:id])
  end

  # POST /fundamental/daily_position_stats
  # POST /fundamental/daily_position_stats.json
  def create
    @fundamental_daily_position_stat = Fundamental::DailyPositionStat.new(params[:fundamental_daily_position_stat])

    respond_to do |format|
      if @fundamental_daily_position_stat.save
        format.html { redirect_to @fundamental_daily_position_stat, notice: 'Daily position stat was successfully created.' }
        format.json { render json: @fundamental_daily_position_stat, status: :created, location: @fundamental_daily_position_stat }
      else
        format.html { render action: "new" }
        format.json { render json: @fundamental_daily_position_stat.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /fundamental/daily_position_stats/1
  # PUT /fundamental/daily_position_stats/1.json
  def update
    @fundamental_daily_position_stat = Fundamental::DailyPositionStat.find(params[:id])

    respond_to do |format|
      if @fundamental_daily_position_stat.update_attributes(params[:fundamental_daily_position_stat])
        format.html { redirect_to @fundamental_daily_position_stat, notice: 'Daily position stat was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @fundamental_daily_position_stat.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /fundamental/daily_position_stats/1
  # DELETE /fundamental/daily_position_stats/1.json
  def destroy
    @fundamental_daily_position_stat = Fundamental::DailyPositionStat.find(params[:id])
    @fundamental_daily_position_stat.destroy

    respond_to do |format|
      format.html { redirect_to fundamental_daily_position_stats_url }
      format.json { head :ok }
    end
  end
end
