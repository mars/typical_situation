# frozen_string_literal: true

class Grandma < ActiveRecord::Base
  has_many :mock_apple_pies, class_name: 'MockApplePie'
end
