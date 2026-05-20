class AttendancesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_event, only: [ :create ]
  before_action :set_attendance, only: [ :accept, :decline, :destroy ]
  before_action :authorize_creator, only: %i[accept decline]
  before_action :authorize_attendee, only: %i[destroy]


  def authorize_creator
    head :forbidden unless @attendance.event.creator == current_user
  end

  def authorize_attendee
    head :forbidden unless @attendance.attendee == current_user
  end


  def create
    @attendance = @event.attendances.build(attendee: current_user, status: :pending)

    if @attendance.save
      redirect_to events_path, notice: "You are attending this event!"
    else
      redirect_to events_path, alert: "Something went wrong!"
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
    redirect_to events_path, notice: "Attendance record was successfully removed!"
  end

  private
  def set_event
    @event = Event.find(params[:event_id])
  end

  def set_attendance
    @attendance = Attendance.find(params[:id])
  end
end
