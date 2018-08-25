class Api::V1::Users::SessionsController < Devise::SessionsController
  
  # POST /v1/users/sign_in
  # Override create to return json
  def create
    @user = warden.authenticate!(auth_options)
    render json: @user, status: :ok
  end
end