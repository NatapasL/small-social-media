# frozen_string_literal: true

module Exceptions
  class Unauthorized < StandardError; end
  class UnprocessableEntity < StandardError; end
  class BadRequest < StandardError; end
  class Forbidden < StandardError; end
  class RouteNotFound < StandardError; end
end
