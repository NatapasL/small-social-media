# frozen_string_literal: true

class PostSerializer < ActiveModel::Serializer
  attributes :id, :text, :created_at, :updated_at, :created_by_id
end
