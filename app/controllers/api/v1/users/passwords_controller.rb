class Api::V1::Users::PasswordsController < Devise::SessionsController
  respond_to :json
  # POST /v1/users/password
  # send reset password
  def create
    self.resource = resource_class.send_reset_password_instructions(resource_params)
    if successfully_sent?(resource)
      head :ok
    else
      # TODO: we might want to return error message instead of just returning resource...?
      render json: resource
    end
  end

  # PATCH /v1/users/password
  def update
    self.resource = resource_class.reset_password_by_token(resource_params)
    if resource.errors.empty?
      resource.unlock_access! if unlockable?(resource)
      render json: {token: JWTWrapper.encode({ user_id: resource.id }), 
                    expires_in: Rails.application.secrets.jwt_expiration_hours}
    else
      set_minimum_password_length
      respond_with resource
    end
  end

end