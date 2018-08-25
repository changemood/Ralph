class  Api::V1::Users::OauthController < Api::V1::BaseController
  skip_before_action :authenticate_user!

  # POST api/v1/users/google
  # return access token from client side
  def google
    uri = "https://www.googleapis.com/oauth2/v3/userinfo"
    response = HTTParty.get(uri, query: {access_token: params[:access_token]})
    @user = User.find_or_create_user_for_google(response.parsed_response.symbolize_keys)
    render json: @user, status: :ok
  end

end