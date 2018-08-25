module Api
  module V1
    module Users
      class UserSerializer < ActiveModel::Serializer
        attributes :id, :username, :email, :token, :expires_in

        def token
          JWTWrapper.encode({ user_id: object.id })
        end
        def expires_in
          Rails.application.secrets.jwt_expiration_hours
        end
      end
    end
  end
end