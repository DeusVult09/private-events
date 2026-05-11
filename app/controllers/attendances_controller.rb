class AttendancesController < ApplicationController
  before_action :set_event, only: %i[create update destroy]

  def set_event
    @event = Event.find(params[:id])
  end

  def create
    @attendance = @event.attendances.build(attendance_params)
  
    if @attendance.save
      redirect_to @event, notice: "You are attending this event!"
    else
      render @event, alert: "Something went wrong!"
    end
  end


  def update
    
  end

  def destroy
  end

  private

  def attendance_params
    params.expect(attendance: [ :attendee, :event, :status ]) 
  end

  #def attendance_params
    #params.require(:attendance).permit(:attendee, :event, :status)
  #end

end
