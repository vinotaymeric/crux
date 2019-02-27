class PagesController < ApplicationController

  skip_before_action :authenticate_user!, only: :home

  def home
    if current_user != nil
    @user_activities = current_user.user_activities 
    else
      @user_activities =[]
    end
  end
end
