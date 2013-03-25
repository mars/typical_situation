require 'test_helper'

class MockApplePiesControllerTest < ActionController::TestCase

  def setup
    @grandma = FactoryGirl.create(:grandma)
    @controller.current_grandma = @grandma
  end

  test "the truth" do
    assert true
  end
end
