class TopicsController < ApplicationController
  before_action :set_topic, only: [:show, :edit, :update, :destroy]
  before_action :correct_user, only: [:edit, :update, :destroy]

  # GET /topics
  # GET /topics.json
  def index
    if params[:category_name]
      @category = Category.find_by_name(params[:category_name])
      @topics = @category.topics.where("user_id > 0").order("CREATED_AT DESC")
    else
      @topics = Topic.where("user_id > 0").order("CREATED_AT DESC")
    end
  end

  # GET /topics/1
  # GET /topics/1.json
  def show
    @agree_comments = @topic.comments.where(is_agree: true)
    @disagree_comments = @topic.comments.where(is_agree: true)
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
