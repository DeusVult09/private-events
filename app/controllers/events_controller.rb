class EventsController < ApplicationController
  before_action :set_event, only: %i[show edit update destroy]

  def set_event
    @event = Event.find(params[:id])
  end

  def index
    @upcoming_events = Event.upcoming.all
    @past_events = Event.past.all
  end

  def show
  end

  def new
    @event = Event.new
  end

  def create
    @event = current_user.created_events.build(event_params)

    if @event.save
      redirect_to @event
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @event.update(event_params)
      redirect_to @event
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy 
    @event.destroy

    redirect_to events_path, notice: "Event was successfully deleted"
  end

  private
  def event_params
    params.expect(event: [:name, :location, :description, :date]) 
  end

  #def event_params
    #params.require(:event).permit(:name, :location, :description, :date)
  #end

end
