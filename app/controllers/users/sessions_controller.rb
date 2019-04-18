# frozen_string_literal: true

class Users::SessionsController < Devise::SessionsController
  # before_action :configure_sign_in_params, only: [:create]

  # GET /resource/sign_in
  def new
    @token = params[:invitation_token] || session[:invitation_token]
    super
  end

  # POST /resource
  def create
    super

    token = params[:invitation_token] || session[:invitation_token]
    if token
      trip = Invitation.find_by(token: token).trip
      Participant.create!(user: current_or_guest_user, trip: trip)
    end
  end

  # DELETE /resource/sign_out
  # def destroy
  #   super
  # end

  # protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_in_params
  #   devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
  # end
end
