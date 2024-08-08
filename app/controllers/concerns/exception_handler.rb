# frozen_string_literal: true

module ExceptionHandler
  extend ActiveSupport::Concern

  included do
    rescue_from(Exceptions::Unauthorized) do
      render json: { errors: 'Unauthorized.' }, status: :unauthorized
    end

    rescue_from(Exceptions::UnprocessableEntity) do |exception|
      render json: { errors: 'Unprocessable.', message: exception }, status: :unprocessable_entity
    end

    rescue_from(Exceptions::BadRequest) do |exception|
      render json: { errors: "There's something wrong with your request.", message: exception }, status: :bad_request
    end

    rescue_from(Exceptions::Forbidden) do
      render json: { errors: 'You are not allowed.' }, status: :forbidden
    end

    rescue_from(ActiveRecord::RecordNotFound) do
      render json: { errors: 'Record not found.' }, status: :not_found
    end

    rescue_from(Exceptions::RouteNotFound) do
      render json: { errors: 'Route not found.' }, status: :not_found
    end

    rescue_from(ActiveRecord::RecordInvalid) do |exception|
      render json: { errors: "Can't save record.", message: exception }, status: :unprocessable_entity
    end

    rescue_from(ActionController::ParameterMissing) do |exception|
      render json: { errors: 'Parameter missing.', message: exception }, status: :bad_request
    end
  end
end
