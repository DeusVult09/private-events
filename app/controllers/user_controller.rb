class UserController < ApplicationController
  before_action :authenticate_user!

  def show
    @created_events = current_user.created_events
    @attending_events = current_user.upcoming_events
  end
end
