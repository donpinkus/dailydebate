class TopicsController < ApplicationController
  before_action :set_topic, only: [:show, :edit, :update, :destroy]
  before_action :correct_user, only: [:edit, :update, :destroy]

  # GET /topics
  # GET /topics.json
  def index
    if params[:category_name]
      @category = Category.find_by_name(params[:category_name])
      @topics = @category.topics.all.order("CREATED_AT DESC")
    else
      @topics = Topic.all.order("CREATED_AT DESC")
    end
  end

  # GET /topics/1
  # GET /topics/1.json
  def show
    # If daily topic, redirect
    if @topic == Topic.where(is_daily_topic: true).first
      redirect_to root_path
    end

    @agree_comments = @topic.comments.where(is_agree: true)
    @disagree_comments = @topic.comments.where(is_agree: false)
  end

  def daily
    @topic = Topic.where(is_daily_topic: true).first
    gon.topic = @topic

    @total_votes = @topic.agree_votes_override.to_i + @topic.disagree_votes_override.to_i + @topic.agree_votes.count
    @agree_count = @topic.agree_votes_override.to_i + @topic.agree_votes.where(is_agree: true).count
    @disagree_count = @topic.disagree_votes_override.to_i + @topic.agree_votes.where(is_agree: false).count

    @agree_comments = @topic.comments.where(is_agree: true).sort_by { |comment| -1 * comment.score }

    @disagree_comments = @topic.comments.where(is_agree: false).sort_by { |comment| -1 * comment.score }

    if Time.now.hour >= 10
      end_time = Time.new(Time.now.year, Time.now.month, Time.now.day + 1, 10)
    else
      end_time = Time.new(Time.now.year, Time.now.month, Time.now.day, 10)
    end

    @time_left = TimeDifference.between(Time.now, end_time).in_general

    render :show
  end

  # GET /topics/new
  def new
    @topic = Topic.new
    gon.categories = Category.all
  end

  # GET /topics/1/edit
  def edit
  end

  # POST /topics
  # POST /topics.json
  def create
    @category_names = JSON.parse(params[:topic][:categories])

    @topic = Topic.new(title: topic_params[:title])

    @topic.user = current_user

    if @topic.save
      @category_names.each do |name|
        # Check if it exists
        if !Category.find_by_name(name).blank?
          @topic.topic_categories.create(category_id: Category.find_by_name(name).id)
        else
          category = Category.create(name: name)
          @topic.topic_categories.create(category_id: category.id)
        end
      end

      if current_user
        redirect_to @topic, notice: "topic published."
      else
        session[:unsaved_topic] = @topic.id
        redirect_to "/auth/facebook"
      end
    else
      gon.categories = Category.all
      render :new
    end
  end

  # PATCH/PUT /topics/1
  # PATCH/PUT /topics/1.json
  def update
    respond_to do |format|
      if @topic.update(topic_params)
        format.html { redirect_to @topic, notice: 'topic was successfully updated.' }
        format.json { render :show, status: :ok, location: @topic }
      else
        format.html { render :edit }
        format.json { render json: @topic.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /topics/1
  # DELETE /topics/1.json
  def destroy
    @topic.destroy
    respond_to do |format|
      format.html { redirect_to topics_url, notice: 'topic was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_topic
      @topic = Topic.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def topic_params
      params.require(:topic).permit(:title, :categories)
    end

    def correct_user
      if @topic.user != current_user
        redirect_to topics_path, notice: "You may only edit topics you own."
      end
    end
end
