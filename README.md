# Typical Situation [![Build Status](https://travis-ci.org/apsislabs/typical_situation.svg?branch=master)](https://travis-ci.org/apsislabs/typical_situation)

The missing Ruby on Rails ActionController REST API mixin.

A Ruby mixin (module) providing the seven standard resource actions & responses for an ActiveRecord :model_type & :collection.

## Installation

Tested in:

- Rails 4.2
- Rails 5.2
- Rails 6.0

Against Ruby versions:

- 2.2
- 2.3
- 2.4
- 2.5

Add to your **Gemfile**:

    gem 'typical_situation'

**Rails 3.2**: For Rails 3.2 support, see https://github.com/mars/typical_situation

## Usage

### Define three methods

    class MockApplePiesController < ApplicationController
      include TypicalSituation

      # Symbolized, underscored version of the model (class) to use as the resource.
      def model_type
        :mock_apple_pie
      end

      # The collection of model instances.
      def collection
        current_user.mock_apple_pies
      end

      # Find a model instance by ID.
      def find_in_collection(id)
        collection.find_by_id(id)
      end
    end

### Get a fully functional REST API

The seven standard resourceful actions:

1. **index**
2. **show**
3. **new**
4. **create**
5. **edit**
6. **update**
7. **delete**

For the content types:

- **HTML**
- **JSON**

With response handling for:

- the collection
- a single instance
- not found
- validation errors (using ActiveModel::Errors format)
- changed
- deleted/gone

### Customize by overriding highly composable methods

`TypicalSituation` is composed of a library of common functionality, which can all be overridden in individual controllers. Express what is _different_ & _special_ about each controller, instead of repeating boilerplate.

The library is split into modules:

- [identity](https://github.com/mars/typical_situation/blob/master/lib/typical_situation/identity.rb) - **required definitions** of the model & how to find it
- [actions](https://github.com/mars/typical_situation/blob/master/lib/typical_situation/actions.rb) - high-level controller actions
- [operations](https://github.com/mars/typical_situation/blob/master/lib/typical_situation/operations.rb) - loading, changing, & persisting the model
- [responses](https://github.com/mars/typical_situation/blob/master/lib/typical_situation/responses.rb) - HTTP responses & redirects

#### Serialization

Under the hood `TypicalSituation` calls `to_json` on your `ActiveRecord` models. This isn't always the optimal way to serialize resources, though, and so `TypicalSituation` offers a simple means of overriding the base Serialization --- either on an individual controller, or for your entire application.

##### ActiveModelSerializers

To use `ActiveModelSerializers`, add an file an initializer called `typical_situation.rb` and override the `Operations` module:

    module TypicalSituation
      module Operations
        def serializable_resource(resource)
          ActiveModelSerializers::SerializableResource.new(resource)
        end
      end
    end

If you'd like to use different serializers per method, you can check `action_name` to determine your current controller endpoint.

    class MockApplePieIndexSerializer < ActiveModel::Serializer
      attributes :id, :ingredients
    end

    module TypicalSituation
      module Operations
        def serializable_resource(resource)
          if action_name == "index"
            ActiveModelSerializers::SerializableResource.new(
              resource,
              each_serializer: MockApplePieIndexSerializer
            )
          else
            ActiveModelSerializers::SerializableResource.new(resource)
          end
        end
      end
    end

##### Blueprinter

`Blueprinter` relies on calling a specific blueprint, it is better suited to being overriden at the controller level. To do so, in your controller file, simply override the `serializable_resource` method as below:

    class MockApplePieBlueprint < Blueprinter::Base
      identifier :id
      fields :ingredients
      association :grandma, blueprint: GrandmaBlueprint
    end

    class MockApplePiesController < ApplicationController
      include TypicalSituation

      def serializable_resource(resource)
        MockApplePieBlueprint.render(resource)
      end
    end

###### Fast JSON API

Like `Blueprinter`,

    class MockApplePieSerializer
      include FastJsonapi::ObjectSerializer
      attributes :ingredients
      belongs_to :grandma
    end

    class MockApplePiesController < ApplicationController
      include TypicalSituation

      def serializable_resource(resource)
        MockApplePieSerializer.new(resource).serializable_hash
      end
    end

## Legalese

This project uses MIT-LICENSE.
