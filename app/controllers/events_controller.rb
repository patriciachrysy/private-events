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
      flash[:notice] = "Unable to create event. Check whether you inputed all fields"
      render :new
    end
  end

  def show
    @event = Event.find(params[:id])
  end

  def index
    @events = Event.all
  end

  private

  def event_params
    params.require(:event).permit(:name, :description, :event_date, :location)
  end
end
