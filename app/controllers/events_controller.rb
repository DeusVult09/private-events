class EventsController < ApplicationController
  def index
    @events = Events.all
  end

  def show
    @event = Event.find(params[:id])
  end

  def new
    @event = Event.new
  end

  def create
  end
end
