class PagesController < ApplicationController

  skip_before_action :authenticate_user!, only: :home

  def home
    @user_activities = current_user.user_activities
  end
end
