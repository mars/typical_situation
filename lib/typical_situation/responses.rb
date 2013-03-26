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
          render :json => include_root? ? { plural_model_type => @resources.as_json } : @resources.as_json
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
          render :json => @resource.as_json(root: include_root?)
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
            changed_so_redirect or render
          end
          format.json do
            render :json => @resource.as_json(root: include_root?)
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
            changed_so_redirect or render
          end
          format.json do
            render :json => @resource.as_json(root: include_root?), 
              :location => @resource.respond_to?(:to_url) ? 
                @resource.to_url : polymorphic_url(@resource), 
              :status => :created
          end
        end
      end
    end
    
    def respond_as_error
      respond_to do |format|
        yield(format) if block_given?
        format.html do
          set_single_instance
          render action: (@resource.new_record? ? :new : :edit), :status => :unprocessable_entity
        end
        format.json do
          render :json => @resource.as_json(root: include_root?, methods: [:errors]), :status => :unprocessable_entity
        end
      end
    end
    
    def respond_as_gone
      respond_to do |format|
        yield(format) if block_given?
        format.html do
          set_single_instance
          gone_so_redirect or render
        end
        format.json do
          render :text => '', :status => :no_content
        end
      end
    end
    
    def respond_as_not_found
      respond_to do |format|
        yield(format) if block_given?
        format.html do
          render :file => not_found_template, :status => :not_found
        end
        format.json do
          render :text => '', :status => :not_found
        end
      end
    end
    
    def respond_as_not_acceptable
      render :text => '', :status => :not_acceptable
    end
    
    # HTML response when @resource saved or updated.
    def changed_so_redirect
      redirect_to @resource
      true # return true when redirecting
    end
    
    # HTML response when @resource deleted.
    def gone_so_redirect
      redirect_to action: :index
      true # return true when redirecting
    end

    def not_found_template
      "#{Rails.root}/public/404"
    end
  end
end
