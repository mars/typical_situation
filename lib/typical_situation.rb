require "typical_situation/engine"
require "typical_situation/identity"
require "typical_situation/actions"
require "typical_situation/operations"
require "typical_situation/responses"

module TypicalSituation
  include Identity
  include Actions
  include Operations
  include Responses

  def self.included(base)
    add_rescues(base)
  end

  def self.add_rescues(action_controller)
    action_controller.class_eval do
      rescue_from ActiveRecord::RecordNotFound, with: :respond_as_not_found
    end
  end
end
