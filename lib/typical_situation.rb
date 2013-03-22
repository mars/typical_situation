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
end
