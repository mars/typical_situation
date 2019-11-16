# frozen_string_literal: true

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
      !@resource.errors.empty?
    end

    def get_resources
      @resources = collection
      set_collection_instance
      @resources
    end

    def new_resource
      @resource = collection.build
    end

    def update_resource(resource, attrs)
      resource.update(attrs)
    end

    def assign_resource(resource, attrs)
      resource.assign_attributes(attrs)
    end

    def destroy_resource(resource)
      resource.destroy
      collection.reload if resource.errors.empty?
      resource
    end

    def create_resource(attrs)
      @resource = collection.create(attrs)
    end

    def build_resource(attrs)
      @resource = collection.build(attrs)
    end

    def model_class
      @model_class ||= model_type.to_s.camelize.constantize
    end

    def serialize_resource(resource, options = {})
      serializable_resource(resource).to_json(options.merge(root: include_root?))
    end

    def serialize_resources(resources)
      if include_root?
        return { plural_model_type => serializable_resource(resources) }
      end

      serializable_resource(resources).to_json(root: false)
    end

    def serializable_resource(resource)
      resource
    end

    # Set the singular instance variable named after the model. Modules are delimited with "_".
    # Example: a MockApplePie resource is set to ivar @mock_apple_pie.
    def set_single_instance
      instance_variable_set(:"@#{model_type.to_s.gsub('/', '__')}", @resource)
    end

    # Set the plural instance variable named after the model. Modules are delimited with "_".
    # Example: a MockApplePie resource collection is set to ivar @mock_apple_pies.
    def set_collection_instance
      instance_variable_set(:"@#{model_type.to_s.gsub('/', '__').pluralize}", @resources)
    end
  end
end
