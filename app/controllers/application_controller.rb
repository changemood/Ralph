class ApplicationController < ActionController::Base
  protect_from_forgery with: :null_session,
                       unless: -> { request.env['REQUEST_PATH'] =~ /^\/v1/ }
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected
  # accept more attributes for devise authentication.
  # I added "username"(others are default) to default devise attributes here.
  def configure_permitted_parameters
    added_attrs = [:username, :email, :password, :password_confirmation, :remember_me]
    devise_parameter_sanitizer.permit :sign_up, keys: added_attrs
    devise_parameter_sanitizer.permit :account_update, keys: added_attrs
  end
end
