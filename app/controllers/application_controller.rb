require 'securerandom'

class ApplicationController < ActionController::Base
  respond_to :html, :js
  protect_from_forgery with: :exception
  before_action :store_location
  before_action :configure_permitted_parameters, if: :devise_controller?
  after_action :current_or_guest_user, if: :devise_controller?, only: :create

  def after_sign_up_path_for(user)
    redirect_to :back
  end

  def execute_statement(sql)
    results = ActiveRecord::Base.connection.execute(sql)

    if results.present?
      return results
    else
      return nil
    end
  end

  def default_url_options
    { host: ENV["HOST"] || "localhost:3000" }
  end

 # if user is logged in, return current_user, else return guest_user
  def current_or_guest_user
    if current_user
      if session[:guest_user_id] && session[:guest_user_id] != current_user.id
        logging_in
        # reload guest_user to prevent caching problems before destruction
        guest_user(with_retry = false).try(:reload).try(:destroy)
        session[:guest_user_id] = nil
      end
      current_user
    else
      guest_user
    end
  end

  # find guest_user object associated with the current session,
  # creating one as needed
  def guest_user(with_retry = true)
    # Cache the value the first time it's gotten.
    @cached_guest_user ||= User.find(session[:guest_user_id] ||= create_guest_user.id)

  rescue ActiveRecord::RecordNotFound # if session[:guest_user_id] invalid
     session[:guest_user_id] = nil
     guest_user if with_retry
  end

  def create
    super
    current_or_guest_user
  end

  private

  def init_mark_down_parser
    renderer = Redcarpet::Render::HTML.new(no_images: true)
    @markdown = Redcarpet::Markdown.new(renderer)
  end

  def configure_permitted_parameters
   devise_parameter_sanitizer.permit(:sign_up) { |u| u.permit(:name, :email, :password, :phone)}
  end

# called (once) when the user logs in
  def logging_in
    guest_user_activities = guest_user.user_activities.all
    guest_user_activities.each do |user_activity|
      user_activity.user_id = current_user.id
      user_activity.save!
    end

    guest_trips = guest_user.trips.all
    guest_trips.each do |trip|
      trip.user_id = current_user.id
      trip.save!
    end
  end

  def store_location
    session[:previous_url] = request.fullpath unless request.fullpath =~ /\/users/ || request.get? == false
  end

  def after_sign_in_path_for(current_or_guest_user)
    session[:previous_url].split("?")[0] || root_path
  end

end
