require_relative '../test_helper'

class MockApplePiesControllerTest < ActionController::TestCase

  PIES_COUNT = 3

  def setup
    @grandma = FactoryGirl.create(:grandma, pies_count: PIES_COUNT)
    @controller.current_grandma = @grandma
  end

  test "GET index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:mock_apple_pies)
    assert_equal PIES_COUNT, assigns(:mock_apple_pies).size
    assert_template :index
  end

  test "GET index JSON" do
    get :index, :format => 'json'
    response_data = nil
    assert_nothing_thrown { response_data = JSON.parse(@response.body) }
    assert_kind_of Hash, response_data
    assert_kind_of Array, response_data['mock_apple_pies']
    assert_equal PIES_COUNT, response_data['mock_apple_pies'].size
  end
end
