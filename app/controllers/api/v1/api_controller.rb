module Api
  module V1
    class ApiController < ApplicationController
      before_action :authenticate_user_from_token!

      private

      def authenticate_user_from_token!
        token = request.headers['Authorization']&.split(' ')&.last
        user = User.find_by(token: token)

        if user
          sign_in user, store: false
        else
          render json: { errors: 'Bad credentials' }, status: :unauthorized
        end
      end
    end
  end
end