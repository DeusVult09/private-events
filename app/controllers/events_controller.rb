class EventsController < ApplicationController
  def index
    @events = Events.all
  end

  def show
  end

  def new
    @event = Event.new
  end

  def create
  end
end
