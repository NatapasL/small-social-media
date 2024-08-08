# frozen_string_literal: true

module Users
  class RegistrationsController < Devise::RegistrationsController
    include ExceptionHandler

    respond_to :json

    private

    def respond_with(current_user, _opts = {})
      if resource.persisted?
        render json: current_user
        return
      end

      raise Exceptions::UnprocessableEntity, current_user.errors.full_messages.to_sentence
    end
  end
end
