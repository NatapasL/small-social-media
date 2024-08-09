# frozen_string_literal: true

module Users
  class RegistrationsController < Devise::RegistrationsController
    include ExceptionHandler
    include RackSessionsFix

    respond_to :json

    private

    def respond_with(current_user, _opts = {})
      raise Exceptions::UnprocessableEntity, current_user.errors.full_messages.to_sentence unless resource.persisted?

      render json: current_user
    end
  end
end
