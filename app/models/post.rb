# frozen_string_literal: true

class Post < ApplicationRecord
  belongs_to :created_by, class_name: 'User'

  validates :text, presence: true, length: { maximum: 100 }
  validates :created_by, presence: true
end
