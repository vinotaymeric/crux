class UserActivitiesController < ApplicationController

  def update
    @user_activity = UserActivity.find_by(user: current_or_guest_user, activity: user_activity_params[:activity_id])
    @user_activity.update!(user_activity_params)
    @user_activity.update!(level: nil) if @user_activity.level == "Niveau ?"
    head 200
  end

  private

  def user_activity_params
    params.require(:user_activity).permit(:level, :activity_id)
  end
end
