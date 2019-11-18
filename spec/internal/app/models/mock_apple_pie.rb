# frozen_string_literal: true

class MockApplePie < ActiveRecord::Base
  belongs_to :grandma
  validates_presence_of :ingredients
  before_destroy :prevent_deleting_real_apple_pie

  def prevent_deleting_real_apple_pie
    return true unless /real apple/i === ingredients

    errors.add(:base, "can't be deleted because it contains real apple")
    false
  end
end
