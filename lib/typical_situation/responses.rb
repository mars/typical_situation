# frozen_string_literal: true

module TypicalSituation
  # Rails MIME responses.
  module Responses
    # Return the collection as HTML or JSON
    #
    def respond_with_resources
      respond_to do |format|
        yield(format) if block_given?

        format.html do
          set_collection_instance
          render
        end
        format.json do
          render json: include_root? ? { plural_model_type => @resources.as_json } : @resources.as_json
        end
      end
    end

    # Return the resource as HTML or JSON
    #
    # A provided block is passed the #respond_to format to further define responses.
    #
    def respond_with_resource
      respond_to do |format|
        yield(format) if block_given?

        format.html do
          set_single_instance
          render
        end
        format.json do
          render json: @resource.as_json(root: include_root?)
        end
      end
    end

    def respond_as_changed
      if has_errors?
        respond_as_error
      else
        respond_to do |format|
          yield(format) if block_given?

          format.html do
            set_single_instance
            changed_so_redirect || render
          end
          format.json do
            render json: @resource.as_json(root: include_root?)
          end
        end
      end
    end

    def respond_as_created
      if has_errors?
        respond_as_error
      else
        respond_to do |format|
          yield(format) if block_given?

          format.html do
            set_single_instance
            changed_so_redirect || render
          end
          format.json do
            render json: @resource.as_json(root: include_root?),
                   location: location_url,
                   status: :created
          end
        end
      end
    end

    def respond_as_error
      respond_to do |format|
        yield(format) if block_given?

        format.html do
          set_single_instance
          render action: (@resource.new_record? ? :new : :edit), status: :unprocessable_entity
        end
        format.json do
          render json: @resource.as_json(root: include_root?, methods: [:errors]), status: :unprocessable_entity
        end
      end
    end

    def respond_as_gone
      if has_errors?
        respond_as_error
      else
        respond_to do |format|
          yield(format) if block_given?

          format.html do
            set_single_instance
            gone_so_redirect || render
          end
          format.json do
            head :no_content
          end
        end
      end
    end

    def respond_as_not_found
      respond_to do |format|
        yield(format) if block_given?

        format.html do
          raise ActionController::RoutingError, 'Not Found'
        end
        format.json do
          head :not_found
        end
      end
    end

    # HTML response when @resource saved or updated.
    def changed_so_redirect
      redirect_to action: :show, id: @resource.to_param
      true # return true when redirecting
    end

    # HTML response when @resource deleted.
    def gone_so_redirect
      redirect_to action: :index
      true # return true when redirecting
    end
  end
end
