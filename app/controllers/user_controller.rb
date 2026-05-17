class UserController < ApplicationController
  before_action :authenticate_user!

  def show
    @created_events = current_user.created_events.includes(attendances: :attendee)

    @pending_attendances = Attendance.joins(events)
    .where(events: { creator_id: current_user.id })
    .where(status: "pending")

    @upcoming_events = Event.joins(attendances)
    .where(attendances: { attendee_id: current_user.id, status: "accepted" })
    .upcoming

    @pending_event = Event.joins(attendances)
    .where(attendances: { attendee_id: current_user.id })

    @
  end
end
