class AttendancesController < ApplicationController
  before_action :set_event, only: %i[create update destroy]

  def set_event
    @event = Event.find(params[:id])
  end

  def create
    @attendance = @event.attendances.build(attendance_params)
  
    if @attendance.save
      redirect_to event_attendances_path(@event), notice: "You are attending this event!"
      @event.status = "pending"
    else
      render event_attendances_path(@event), alert: "Something went wrong!"
    end
  end


  def update
    if @attendance.update(attendance_params)
      redirect_to event_attendances_path(@path)
    else
      render :, status: :unprocessable_entity
    end
  end

  def destroy
    @attendance.destroy

    redirect_to user_path(@user), notice: "Attendance record was successfully removed!"
  end
  
  private

  def attendance_params
    params.expect(attendance: [ :attendee, :event, :status ]) 
  end

  #def attendance_params
    #params.require(:attendance).permit(:attendee, :event, :status)
  #end

end
