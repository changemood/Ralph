class Api::V1::Users::RegistrationsController < Devise::RegistrationsController
  respond_to :json

  # POST api/v1/users
  # Override create to return json
  def create
    build_resource(sign_up_params)
    resource.save
    if resource.persisted?
      render json: resource, status: :ok
    else
      clean_up_passwords resource
      set_minimum_password_length
      respond_with resource
    end
  end
end