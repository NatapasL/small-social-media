# frozen_string_literal: true

FactoryBot.define do
  factory :post do
    text { 'Hello, world' }
    association :created_by, factory: :user
  end
end
