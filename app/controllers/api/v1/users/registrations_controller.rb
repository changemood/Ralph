class Api::V1::Users::RegistrationsController < Devise::RegistrationsController
  respond_to :json

  # Override create to return json
  def create
    build_resource(sign_up_params)
    resource.save
    if resource.persisted?
      render json: {user_id: resource.id, token: JWTWrapper.encode({ user_id: resource.id }), expires_in: Rails.application.secrets.jwt_expiration_hours}
    else
      clean_up_passwords resource
      set_minimum_password_length
      respond_with resource
    end
  end
end