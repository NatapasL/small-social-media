# frozen_string_literal: true

module Users
  class SessionsController < Devise::SessionsController
    include ExceptionHandler

    respond_to :json

    private

    def respond_with(current_user, _opts = {})
      raise Exceptions::Unauthorized unless current_user

      render json: current_user, status: :ok
    end

    def respond_to_on_destroy
      raise Exceptions::Unauthorized unless request.headers['Authorization'].present?

      jwt_payload = JWT.decode(request.headers['Authorization'].split(' ').last,
                               Rails.application.credentials.devise_jwt_secret_key!).first
      current_user = User.find(jwt_payload['sub'])

      raise Exceptions::Unauthorized unless current_user

      render json: { success: true }, status: :ok
    end
  end
end
