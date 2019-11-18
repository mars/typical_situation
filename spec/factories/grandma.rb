# frozen_string_literal: true

FactoryBot.define do
  factory :grandma do
    name { 'Annie' }

    transient do
      pies_count { 5 }
    end

    after(:build) do |grandma, evaluator|
      create_list(:mock_apple_pie, evaluator.pies_count, grandma: grandma)
    end
  end
end
