class ApplicationController < ActionController::Base
  protect_from_forgery with: :null_session
  before_action :configure_permitted_parameters, if: :devise_controller?

  skip_before_action :verify_authenticity_token, if: :json_request?
  def json_request?
    request.format.json?
  end

  #skip_before_filter :verify_authenticity_token

  # This is our new function that comes before Devise's one
  # before_filter :authenticate_user_from_token!
  # This is Devise's authentication
  # before_filter :authenticate_user!

  def current_user
    User.find_by_authentication_token(params[:auth_token]) || ( warden.authenticate(scope: :user) rescue nil)
    #@current_user ||= User.find(session[:user_id]) if session[:user_id]
  end
  #helper_method :current_user
  def remember_token
    data = User.serialize_into_cookie @user
    "#{data.first.first}-#{data.last}"
  end

  # rescue_from CanCan::AccessDenied do |exception|
  #   flash[:notice] = "Access denied!"
  #   redirect_to root_path
  # end

  def after_sign_in_path_for(resource)
    root_path
  end

  private

  # For this example, we are simply using token authentication
  # via parameters. However, anyone could use Rails's token
  # authentication features to get the token from a header.
  def authenticate_user_from_token!
    user_token = params[:user_token].presence
    user       = user_token && User.find_by_authentication_token(user_token.to_s)

    if user
      # Notice we are passing store false, so the user is not
      # actually stored in the session and a token is needed
      # for every request. If you want the token to work as a
      # sign in token, you can simply remove store: false.
      sign_in user, store: false
    end
  end

  def invalid_credentials
    render json: {}, status: 401
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) { |u| u.permit(:email, :password, :image, :password_confirmation) }
  end
end
