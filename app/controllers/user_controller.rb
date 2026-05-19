class UserController < ApplicationController
  before_action :authenticate_user!

  def show
    @created_events = current_user.created_events.includes(attendances: :attendee)

    @upcoming_events = Event.joins(attendances)
    .where(attendances: { attendee_id: current_user.id, status: "accepted" })
    .upcoming

    @pending_events = Event.joins(attendances)
    .where(attendances: { attendee_id: current_user.id, status: "pending" })

    @declined_events = Event.joins(attendances)
    .where(attendances: { attendee_id: current_user.id, status: "declined" })

    @past_events = Event.joins(attendances)
    .where(attendances: {attendee_id: current_user.id, status: "accepted" })
    .past
    
  end
end
