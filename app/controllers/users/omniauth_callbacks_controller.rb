class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def google
    data = {
      email: request.env["omniauth.auth"].info.email,
      name: request.env["omniauth.auth"].info.name
    }
    @user = User.find_or_create_user_for_google(data)
    sign_in(@user)
    redirect_to root_path
  end
end
