class MockApplePie < ActiveRecord::Base
  attr_accessible :grandma_id, :ingredients

  belongs_to :grandma
end