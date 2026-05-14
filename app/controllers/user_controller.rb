class UserController < ApplicationController
  before_action :authenticate_user!
  before_action :set_attendance

  def set_attendance
    @attendance = Attendance.find(params[:eveid])
  end


  def show
    @created_events = current_user.created_events
    @pending_attendances = @attendance.event.creator == current_user && @attendance.status == "pending"
    @attending_events = current_user.upcoming_events
  end
end
