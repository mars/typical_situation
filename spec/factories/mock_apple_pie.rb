# frozen_string_literal: true

FactoryBot.define do
  factory :mock_apple_pie do
    ingredients { 'flour, sugar, water, butter, eggs, milk, Ritz crackers, lemon, vanilla, cinnamon' }
    grandma
  end
end
