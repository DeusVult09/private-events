class UserController < ApplicationController
  before_action :authenticate_user!

  def show
    @user = User.find(params[:id])
    @user_events = @user.events
  end
end
