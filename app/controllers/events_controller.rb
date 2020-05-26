class EventsController < ApplicationController
  before_action :user_signed_in, only: %i[new create]

  def user_signed_in
    if session[:current_user].nil?
      flash[:notice] = "You need to sign in before creating an event"
      redirect_to sign_in_path 
      return false
    end
  end
  
  def new
    @event = Event.new

  end

  def create
    @user = User.find_by(username: session[:current_user])
    @event = @user.created_events.new(event_params)
    if @event.save
      redirect_to event_path @event
    else
      flash[:notice] = "Unable to create event. 
                        Check whether you inputed all fields"
      render :new
    end
  end

  def show
    @users = User.all
    @event = Event.find(params[:id])
  end

  def index
    @events = Event.all
    @user = User.find_by(username: session[:current_user])
    @pending_events = @events.map {|event| event if @user.pending_events?(event)}.compact if @user
    @upcoming_events = @events.upcoming
    @previous_events = @events.previous
  end

  def attend_event
    @user = User.find_by(username: session[:current_user])
    @event = Event.find_by(id: params[:event_id])
    @attendance = @user.attendances.build(attended_event: @event)
    @attendance.save
    redirect_to root_path
  end

  private

  def event_params
    params.require(:event).permit(:name, :description, :event_date, :location)
  end
end
