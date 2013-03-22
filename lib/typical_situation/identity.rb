module TypicalSituation

  # These Identity methods must be defined for each implementation.
  module Identity
    
    # Symbolized, underscored version of the model (class) to use.
    def model_type
      raise(RuntimeError, "#model_type must be defined in the TypicalSituation implementation.")
    end
    
    # The collection of model instances.
    def collection
      raise(RuntimeError, "#collection must be defined in the TypicalSituation implementation.")
    end
    
    # Find a model instance by ID. 
    def find_in_collection(id)
      raise(RuntimeError, "#find_in_collection must be defined in the TypicalSituation implementation.")
    end

    def include_root?
      true
    end
  end
end
