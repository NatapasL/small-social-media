# frozen_string_literal: true

class AuthenticatedApplicationController < ApplicationController
  before_action :authenticate_user!
end
