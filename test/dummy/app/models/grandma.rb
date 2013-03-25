class Grandma < ActiveRecord::Base
  attr_accessible :name
  has_many :mock_apple_pies, :class_name => 'MockApplePie'
end
