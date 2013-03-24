FactoryGirl.define do
  
  sequence :rating do |n|
    sprintf("%01d", rand(n))
  end

  factory :mock_apple_pie do
    rating { generate(:rating) }
    grandma
  end
end
