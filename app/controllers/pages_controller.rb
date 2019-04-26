class PagesController < ApplicationController
  def home
    @user = current_user
    gon.user = @user
  end
end
