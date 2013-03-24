class MockApplePiesController < ApplicationController
  include TypicalSituation

  attr_accessor :current_grandma

  # Symbolized, underscored version of the model (class) to use.
  def model_type
    :mock_apple_pie
  end
  
  # The collection of model instances.
  def collection
    current_grandma.mock_apple_pies
  end
  
  # Find a model instance by ID. 
  def find_in_collection(id)
    collection.find_by_id(id)
  end
end
