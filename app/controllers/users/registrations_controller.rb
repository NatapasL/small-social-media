# frozen_string_literal: true

module Users
  class RegistrationsController < Devise::RegistrationsController
    respond_to :json

    private

    def respond_with(current_user, _opts = {})
      if resource.persisted?
        render json: {
          message: 'Signed up successfully.',
          user: { email: current_user.email }
        }
        return
      end

      render json: {
        message: "User couldn't be created successfully. #{current_user.errors.full_messages.to_sentence}"
      }, status: :unprocessable_entity
    end
  end
end
