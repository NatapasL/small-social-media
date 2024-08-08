# frozen_string_literal: true

class ApplicationController < ActionController::API
  include ExceptionHandler

  def not_found
    raise Exceptions::RouteNotFound
  end
end
