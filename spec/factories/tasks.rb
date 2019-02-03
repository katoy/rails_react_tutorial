# frozen_string_literal: true

FactoryBot.define do
  factory :task do
    sequence(:title) { |n| "Title_#{n}" }
    sequence(:description) { |n| "memo_#{n}" }
  end
end
