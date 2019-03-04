class UserActivitiesController < ApplicationController

  def update
    @user_activity = UserActivity.find_by(user: current_user, activity: user_activity_params[:activity_id])
    @user_activity.update!(user_activity_params)
    redirect_to new_trip_path
    # p @user_activity
    # redirect_to new_trip_path
  end

  private

  def user_activity_params
    params.require(:user_activity).permit(:level, :activity_id)
  end
end
