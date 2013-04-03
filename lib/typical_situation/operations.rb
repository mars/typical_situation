module TypicalSituation

  # Model operations.
  # Assume that we're working w/ an ActiveRecord association collection.
  module Operations
    
    def get_resource
      if (@resource = find_in_collection(params[:id]))
        set_single_instance
        @resource
      else
        raise ActiveRecord::RecordNotFound, "Could not find #{model_class}( id:#{params[:id].inspect} )"
      end
    end
    
    def has_errors?
      not @resource.errors.empty?
    end
    
    def get_resources
      @resources = collection
      set_collection_instance
      @resources
    end
    
    def new_resource
      @resource = collection.build
    end
  
    # Avoid assignment of protected attributes.
    def update_resource(resource, attrs)
      safe_attrs = attrs.slice(*model_class.accessible_attributes.to_a)
      resource.update_attributes(safe_attrs)
    end
  
    def destroy_resource(resource)
      resource.destroy
      collection.reload
      resource
    end
  
    def create_resource(attrs)
      @resource = collection.create(attrs)
    end
    
    def model_class
      @model_class ||= model_type.to_s.camelize.constantize
    end
    
    # Set the singular instance variable named after the model. Modules are delimited with "__".
    # Example: a MockApplePie resource is set to ivar @mock_apple_pie.
    def set_single_instance
      instance_variable_set(:"@#{model_type.to_s.gsub('/', '__')}", @resource)
    end
    
    # Set the plural instance variable named after the model. Modules are delimited with "__".
    # Example: a MockApplePie resource collection is set to ivar @mock_apple_pies.
    def set_collection_instance
      instance_variable_set(:"@#{model_type.to_s.gsub('/', '__').pluralize}", @resources)
    end
  end
end
