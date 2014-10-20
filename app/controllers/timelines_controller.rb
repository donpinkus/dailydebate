class TimelinesController < ApplicationController
  before_action :set_timeline, only: [:show, :edit, :update, :destroy]
  before_action :correct_user, only: [:edit, :update, :destroy]

  # GET /timelines
  # GET /timelines.json
  def index
    if params[:tag]
      @tag = Tag.find_by_name(params[:tag])
      @timelines = @tag.timelines.where("user_id > 0").order("CREATED_AT DESC")
    else
      @timelines = Timeline.where("user_id > 0").order("CREATED_AT DESC")
    end 
  end

  # GET /timelines/1
  # GET /timelines/1.json
  def show
    # trying to place things on timeline
    # (D / T) * (# of pixels in the line)
    if @timeline.events.where("user_id > 0").count > 0
      events = @timeline.events.where("user_id > 0").order("date ASC")
      @start_date = events.first.date
      end_date = events.last.date
      @total_time_length = end_date - @start_date
    end
  end

  # GET /timelines/new
  def new
    @timeline = Timeline.new
  end

  # GET /timelines/1/edit
  def edit
  end

  # POST /timelines
  # POST /timelines.json
  def create
    @timeline = Timeline.new(timeline_params)

    @timeline.user = current_user

    if @timeline.save
      if current_user
        redirect_to @timeline, notice: "Timeline published."
      else
        session[:unsaved_timeline] = @timeline.id
        redirect_to "/auth/facebook"
      end
    else
      render :new
    end
  end

  # PATCH/PUT /timelines/1
  # PATCH/PUT /timelines/1.json
  def update
    respond_to do |format|
      if @timeline.update(timeline_params)
        format.html { redirect_to @timeline, notice: 'Timeline was successfully updated.' }
        format.json { render :show, status: :ok, location: @timeline }
      else
        format.html { render :edit }
        format.json { render json: @timeline.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /timelines/1
  # DELETE /timelines/1.json
  def destroy
    @timeline.destroy
    respond_to do |format|
      format.html { redirect_to timelines_url, notice: 'Timeline was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_timeline
      @timeline = Timeline.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def timeline_params
      params.require(:timeline).permit(:title, :tagline, :description)
    end

    def correct_user
      if @timeline.user != current_user
        redirect_to timelines_path, notice: "You may only edit timelines you own."
      end
    end
end
