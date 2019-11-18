# frozen_string_literal: true

module TypicalSituation
  # These Identity methods must be defined for each implementation.
  module Identity
    # Symbolized, underscored version of the model (class) to use.
    def model_type
      raise(NotImplementedError, '#model_type must be defined in the TypicalSituation implementation.')
    end

    def model_params
      params.require(model_type.to_sym)
    end

    def create_params
      if permitted_create_params.nil? || permitted_create_params.empty?
        return model_params.permit!
      end

      model_params.permit(permitted_create_params)
    end

    def update_params
      if permitted_update_params.nil? || permitted_update_params.empty?
        return model_params.permit!
      end

      model_params.permit(permitted_update_params)
    end

    def permitted_create_params
      nil
    end

    def permitted_update_params
      nil
    end

    # The collection of model instances.
    def collection
      raise(NotImplementedError, '#collection must be defined in the TypicalSituation implementation.')
    end

    # Find a model instance by ID.
    def find_in_collection(_id)
      raise(NotImplementedError, '#find_in_collection must be defined in the TypicalSituation implementation.')
    end

    def include_root?
      true
    end

    def plural_model_type
      model_type.to_s.pluralize.intern
    end

    def location_url
      return if @resource.nil? || @resource.new_record?

      @resource.respond_to?(:to_url) ?
        @resource.to_url : polymorphic_url(@resource)
    end
  end
end
