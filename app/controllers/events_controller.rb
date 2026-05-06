class EventsController < ApplicationController
  def index
    @events = Event.all
  end

  def show
    @event = Event.find(params[:id])
  end

  def new
    @event = Event.new
  end

  def create
    @event = current_user.attended_events.build(event_params)

    if @event.save
      redirect_to events_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  private
  def event_params
    params.expect(event: [:name, :location, :description, :date]) 
  end

  #def event_params
    #params.require(:event).permit(:name, :location, :description, :date)
  #end

end
