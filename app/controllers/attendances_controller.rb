class AttendancesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_event, only: [:create]
  before_action :set_attendance, only: [:accept, :decline, :destroy]

  def create
    @attendance = @event.attendances.build(attendee: current_user, status: :pending)
  
    if @attendance.save
      redirect_to user_path(current_user), notice: "You are attending this event!"
    else
      redirect_to user_path(current_user), alert: "Something went wrong!"
    end
  end

  def accept
    if @attendance.update(status: :accepted)
      redirect_to user_path(current_user), notice: "Accepted"
    end
  end

  def decline
    if @attendance.update(status: :declined)
      redirect_to user_path(current_user), notice: "Declined"
    end
  end

  def destroy
    @attendance.destroy
    redirect_to user_path(current_user), notice: "Attendance record was successfully removed!"
  end

  private
  def set_event
    @event = Event.find(params[:event_id])
  end

  def set_attendance
    @attendance = Attendance.find(params[:id])
  end

end
