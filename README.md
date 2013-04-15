# Typical Situation [![Build Status](https://travis-ci.org/mars/typical_situation.png)](https://travis-ci.org/mars/typical_situation)

The missing Ruby on Rails ActionController REST API mixin.

A Ruby mixin (module) providing the seven standard resource actions & responses for an ActiveRecord :model_type & :collection.

## Installation

Requires (tested in) **Rails 3.2** & **Ruby 1.9**.

Add to your **Gemfile**:

    gem 'typical_situation', github: 'mars/typical_situation'

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
  * changed
  * deleted/gone

### Customize by overriding highly composable methods

**TypicalSituation** is composed of a library of common functionality, which can all be overridden in individual controllers. Express what is *different* & *special* about each controller, instead of repeating boilerplate.

The library is split into modules:

  * [identity](https://github.com/mars/typical_situation/blob/master/lib/typical_situation/identity.rb) - **required definitions** of the model & how to find it
  * [actions](https://github.com/mars/typical_situation/blob/master/lib/typical_situation/actions.rb) - high-level controller actions
  * [operations](https://github.com/mars/typical_situation/blob/master/lib/typical_situation/operations.rb) - loading, changing, & persisting the model
  * [responses](https://github.com/mars/typical_situation/blob/master/lib/typical_situation/responses.rb) - HTTP responses & redirects

## Legalese

This project uses MIT-LICENSE.
