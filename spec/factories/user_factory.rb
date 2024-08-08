# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    sequence(:id) { |n| n }
    sequence(:email) { |n| "user#{n}@email.com" }
    password { '123456' }
  end
end
