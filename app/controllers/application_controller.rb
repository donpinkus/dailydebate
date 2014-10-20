class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_action :save_unsaved_events
  before_action :save_unsaved_timelines

  private

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def save_unsaved_events
  	if current_user && session[:unsaved_event]
  		@event = Event.find(session[:unsaved_event])
  		@event.user = current_user
  		if @event.save
  			session[:unsaved_event] = nil
  			redirect_to timeline_path(@event.timeline), notice: 'Event published.'
  		end
  	end
  end

  def save_unsaved_timelines
    if current_user && session[:unsaved_timeline]
      @timeline = Timeline.find(session[:unsaved_timeline])
      @timeline.user = current_user
      if @timeline.save
        session[:unsaved_timeline] = nil
        redirect_to timeline_path(@timeline), notice: 'Timeline published.'
      end
    end
  end
  
  helper_method :current_user
end
