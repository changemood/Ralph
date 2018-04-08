class Api::V1::Users::ConfirmationsController < Devise::RegistrationsController

  # POST /api/vi/users/confirmation
  # send confirmation email again
  def create
    self.resource = resource_class.send_confirmation_instructions(resource_params)
    yield resource if block_given?

    if successfully_sent?(resource)
      head :ok
    else
      # TODO: we might want to return error message instead of just returning resource...?
      render json: resource
    end
  end

  # GET /api/vi/users/confirmation?confirmation_token=abcdef
  def show
    self.resource = resource_class.confirm_by_token(params[:confirmation_token])
    yield resource if block_given?

    if resource.errors.empty?
      render json: {user_id: resource.id, token: JWTWrapper.encode({ user_id: resource.id }), expires_in: Rails.application.secrets.jwt_expiration_hours}
    else
      render json: resource.errors, status: :unprocessable_entity
    end
  end
end