class ApplicationController < ActionController::Base
  # Prcomment CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_action :save_unsaved_comments
  before_action :save_unsaved_topics

  private

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def save_unsaved_comments
  	if current_user && session[:unsaved_comment]
  		@comment = Comment.find(session[:unsaved_comment])
  		@comment.user = current_user
  		if @comment.save
  			session[:unsaved_comment] = nil
  			redirect_to topic_path(@comment.topic), notice: 'comment published.'
  		end
  	end
  end

  def save_unsaved_topics
    if current_user && session[:unsaved_topic]
      @topic = Topic.find(session[:unsaved_topic])
      @topic.user = current_user
      if @topic.save
        session[:unsaved_topic] = nil
        redirect_to topic_path(@topic), notice: 'topic published.'
      end
    end
  end

  helper_method :current_user
end
