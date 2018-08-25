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

  # PUT /resource
  # We need to use a copy of the resource because we don't want to change
  # the current user in place.
  def update
    self.resource = resource_class.to_adapter.get!(send(:"current_#{resource_name}").to_key)
    prev_unconfirmed_email = resource.unconfirmed_email if resource.respond_to?(:unconfirmed_email)

    resource_updated = update_resource(resource, account_update_params)
    yield resource if block_given?
    if resource_updated
      render json: resource, status: :ok      
    else
      respond_with resource
    end
  end

  protected
  # NOTE: Overwriting this because we don't require password to update user
  # By default on devise, require a password checks on update.
  def update_resource(resource, params)
    resource.update_without_password(params)
  end
end