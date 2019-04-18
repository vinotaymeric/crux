class InvitationsController < ApplicationController

  def create
    @invitation = Invitation.new(invitation_params)
    if @invitation.save
      redirect_back(fallback_location: root_path, notice: "Invitation envoyée")
    else
      redirect_back(fallback_location: root_path, alert: @invitation.errors.full_messages)
    end
  end

  private

  def invitation_params
    params.require(:invitation).permit(:trip_id, :mailed_to)
  end
end
