# Typical Situation [![Build Status](https://travis-ci.org/mars/typical_situation.png)](https://travis-ci.org/mars/typical_situation)

The missing Rails ActionController REST API mixin.

`TypicalSituation` is a Ruby mixin (module) providing the seven standard resource actions & responses for an ActiveRecord :model_type & :collection.

## Usage

Requires (tested in) **Rails 3.2** & **Ruby 1.9**.

Add to your **Gemfile**:

    gem 'typical_situation', github: 'mars/typical_situation'

Then, a controller may be defined like:

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

Which provides the seven standard resourceful actions:

  1. **index**
  1. **show**
  1. **new**
  1. **create**
  1. **edit**
  1. **update**
  1. **delete**

For the content types:

  * **HTML**
  * **JSON**

With response handling for:

  * the collection
  * a single instance
  * not found
  * validation errors (using ActiveModel::Errors format)
  * deleted/gone

## Legalese

This project uses MIT-LICENSE.
