FactoryGirl.define do
  
  factory :grandma do
    name "Annie"

    ignore do
      pies_count 5
    end

    after(:build) do |grandma, evaluator|
      FactoryGirl.create_list(:mock_apple_pie, evaluator.pies_count, grandma: grandma)
    end

  end
end
