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
    get :index, format: 'json'
    assert_response :success
    response_data = nil
    assert_nothing_thrown { response_data = JSON.parse(@response.body) }
    assert_kind_of Hash, response_data
    assert_kind_of Array, response_data['mock_apple_pies']
    assert_equal PIES_COUNT, response_data['mock_apple_pies'].size
    response_data['mock_apple_pies'].each do |pie_data|
      assert_equal @grandma.id, pie_data['grandma_id']
      assert_not_nil pie_data['ingredients']
    end
  end

  test "GET show" do
    pie = @grandma.mock_apple_pies.first
    get :show, id: pie.to_param
    assert_response :success
    assert_not_nil assigns(:mock_apple_pie)
    assert_kind_of MockApplePie, assigns(:mock_apple_pie)
    assert_template :show
  end

  test "GET show (not found)" do
    get :show, id: '555'
    assert_response :not_found
  end

  test "GET show JSON" do
    pie = @grandma.mock_apple_pies.first
    get :show, id: pie.to_param, format: 'json'
    assert_response :success
    response_data = nil
    assert_nothing_thrown { response_data = JSON.parse(@response.body) }
    assert_kind_of Hash, response_data
    assert_kind_of Hash, response_data['mock_apple_pie']
    assert_equal @grandma.id, response_data['mock_apple_pie']['grandma_id']
    assert_not_nil response_data['mock_apple_pie']['ingredients']
  end

  test "GET new" do
    get :new
    assert_response :success
    assert_not_nil assigns(:mock_apple_pie)
    assert_kind_of MockApplePie, assigns(:mock_apple_pie)
    assert_template :new
  end

  test "GET new JSON" do
    get :new, format: 'json'
    assert_response :success
    response_data = nil
    assert_nothing_thrown { response_data = JSON.parse(@response.body) }
    assert_kind_of Hash, response_data
    assert_kind_of Hash, response_data['mock_apple_pie']
    assert response_data['mock_apple_pie'].has_key? 'grandma_id'
    assert response_data['mock_apple_pie'].has_key? 'ingredients'
  end

  test "POST create" do
    new_attrs = { mock_apple_pie: { ingredients: 'love', grandma_id: @grandma.id }}
    post :create, new_attrs
    pie = MockApplePie.all.last
    assert_response :redirect
    assert_redirected_to controller: 'mock_apple_pies', action: 'show', id: pie.to_param
  end

  test "POST create (validation error)" do
    new_attrs = { mock_apple_pie: { ingredients: '', grandma_id: @grandma.id }}
    post :create, new_attrs
    assert_response :unprocessable_entity
  end

  test "POST create JSON" do
    new_attrs = { mock_apple_pie: { ingredients: 'love', grandma_id: @grandma.id }}
    post :create, new_attrs.merge( format: 'json' )
    assert_response :created
    response_data = nil
    assert_nothing_thrown { response_data = JSON.parse(@response.body) }
    assert_kind_of Hash, response_data
    assert_kind_of Hash, response_data['mock_apple_pie']
    assert_equal new_attrs[:mock_apple_pie][:grandma_id], response_data['mock_apple_pie']['grandma_id']
    assert_equal new_attrs[:mock_apple_pie][:ingredients], response_data['mock_apple_pie']['ingredients']
  end

  test "POST create JSON (validation error)" do
    new_attrs = { mock_apple_pie: { ingredients: '', grandma_id: @grandma.id }}
    post :create, new_attrs.merge( format: 'json' )
    assert_response :unprocessable_entity
    response_data = nil
    assert_nothing_thrown { response_data = JSON.parse(@response.body) }
    assert_kind_of Hash, response_data
    assert_kind_of Hash, response_data['mock_apple_pie']
    assert_equal new_attrs[:mock_apple_pie][:grandma_id], response_data['mock_apple_pie']['grandma_id']
    assert_equal new_attrs[:mock_apple_pie][:ingredients], response_data['mock_apple_pie']['ingredients']
    assert_equal ["can't be blank"], response_data['mock_apple_pie']['errors']['ingredients']
  end

  test "GET edit" do
    pie = @grandma.mock_apple_pies.first
    get :edit, id: pie.to_param
    assert_response :success
    assert_not_nil assigns(:mock_apple_pie)
    assert_kind_of MockApplePie, assigns(:mock_apple_pie)
    assert_template :edit
  end

  test "GET edit (not found)" do
    get :edit, id: '555'
    assert_response :not_found
  end

  test "GET edit JSON" do
    pie = @grandma.mock_apple_pies.first
    get :edit, id: pie.to_param, format: 'json'
    assert_response :success
    response_data = nil
    assert_nothing_thrown { response_data = JSON.parse(@response.body) }
    assert_kind_of Hash, response_data
    assert_kind_of Hash, response_data['mock_apple_pie']
    assert_equal @grandma.id, response_data['mock_apple_pie']['grandma_id']
    assert_equal pie.ingredients, response_data['mock_apple_pie']['ingredients']
  end

  test "PUT update" do
    pie = @grandma.mock_apple_pies.first
    update_attrs = { mock_apple_pie: { ingredients: 'lots of love', grandma_id: pie.grandma.id }}
    put :update, update_attrs.merge( id: pie.to_param )
    assert_response :redirect
    assert_redirected_to controller: 'mock_apple_pies', action: 'show', id: pie.to_param
  end

  test "PUT update (not found)" do
    pie = @grandma.mock_apple_pies.first
    update_attrs = { mock_apple_pie: { ingredients: 'lots of love', grandma_id: pie.grandma.id }}
    put :update, update_attrs.merge( id: '555' )
    assert_response :not_found
  end

  test "PUT update (validation error)" do
    pie = @grandma.mock_apple_pies.first
    update_attrs = { mock_apple_pie: { ingredients: '', grandma_id: pie.grandma.id }}
    put :update, update_attrs.merge( id: pie.to_param )
    assert_response :unprocessable_entity
  end

  test "PUT update JSON" do
    pie = @grandma.mock_apple_pies.first
    update_attrs = { mock_apple_pie: { ingredients: 'lots of love', grandma_id: pie.grandma.id }}
    put :update, update_attrs.merge( id: pie.to_param, format: 'json' )
    assert_response :success
    response_data = nil
    assert_nothing_thrown { response_data = JSON.parse(@response.body) }
    assert_kind_of Hash, response_data
    assert_kind_of Hash, response_data['mock_apple_pie']
    assert_equal update_attrs[:mock_apple_pie][:grandma_id], response_data['mock_apple_pie']['grandma_id']
    assert_equal update_attrs[:mock_apple_pie][:ingredients], response_data['mock_apple_pie']['ingredients']
  end

  test "PUT update JSON (validation error)" do
    pie = @grandma.mock_apple_pies.first
    update_attrs = { mock_apple_pie: { ingredients: '', grandma_id: pie.grandma.id }}
    put :update, update_attrs.merge( id: pie.to_param, format: 'json' )
    assert_response :unprocessable_entity
    response_data = nil
    assert_nothing_thrown { response_data = JSON.parse(@response.body) }
    assert_kind_of Hash, response_data
    assert_kind_of Hash, response_data['mock_apple_pie']
    assert_equal update_attrs[:mock_apple_pie][:grandma_id], response_data['mock_apple_pie']['grandma_id']
    assert_equal update_attrs[:mock_apple_pie][:ingredients], response_data['mock_apple_pie']['ingredients']
    assert_equal ["can't be blank"], response_data['mock_apple_pie']['errors']['ingredients']
  end

  test "DELETE destroy" do
    pie = @grandma.mock_apple_pies.first
    delete :destroy, id: pie.to_param
    assert_response :redirect
    assert_redirected_to controller: 'mock_apple_pies', action: 'index'
  end

  test "DELETE destroy (not_found)" do
    delete :destroy, id: '555'
    assert_response :not_found
  end

  test "DELETE destroy JSON" do
    pie = @grandma.mock_apple_pies.first
    delete :destroy, id: pie.to_param, format: 'json'
    assert_response :no_content
    assert_empty @response.body
  end

  test "DELETE destroy JSON (validation error)" do
    pie = @grandma.mock_apple_pies.first
    pie.update_attribute(:ingredients, 'sugar, real apples, flour, butter, and egg.')
    delete :destroy, id: pie.to_param, format: 'json'
    assert_response :unprocessable_entity
    response_data = nil
    assert_nothing_thrown { response_data = JSON.parse(@response.body) }
    assert_equal ["can't be deleted because it contains real apple"], response_data['mock_apple_pie']['errors']['base']
  end

end
