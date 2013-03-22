module TypicalSituation
  
  # Standard REST/CRUD actions.
  module Actions
    
    def index
      get_resources
      respond_with_resources
    end
    
    def show
      get_resource
      respond_with_resource
    end
    
    def edit
      get_resource
      respond_with_resource
    end
    
    def new
      new_resource
      respond_with_resource
    end
    
    def update
      get_resource
      update_resource(@resource, params[model_type])
      respond_as_changed
    end
    
    def destroy
      get_resource
      destroy_resource(@resource)
      respond_as_gone
    end
    
    def create
      @resource = create_resource(params[model_type])
      respond_as_created
    end
  end
end
