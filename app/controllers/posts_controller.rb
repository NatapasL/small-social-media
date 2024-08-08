# frozen_string_literal: true

class PostsController < ApplicationController
  def index
    render json: { success: current_user }
  end
end
