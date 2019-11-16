# frozen_string_literal: true

require 'spec_helper'

PIES_COUNT = 5

RSpec.describe MockApplePiesController, type: :controller do
  before(:each) do
    @grandma = create(:grandma, pies_count: PIES_COUNT)
    controller.current_grandma = @grandma
  end

  let(:pie) { @grandma.mock_apple_pies.first }

  describe 'GET #index' do
    context 'html' do
      it 'renders the index template' do
        get :index

        expect(response).to have_http_status :ok
        expect(response).to render_template(:index)
        expect(assigns(:mock_apple_pies)).not_to be nil
        expect(assigns(:mock_apple_pies).size).to eq PIES_COUNT
      end
    end

    context 'json' do
      it 'renders index JSON' do
        get :index, format: :json

        response_body = JSON.parse(response.body)

        expect(response).to have_http_status :ok
        expect(response_body).to be_a Hash
        expect(response_body['mock_apple_pies']).to be_a Array
        expect(response_body['mock_apple_pies'].size).to eq PIES_COUNT

        response_body['mock_apple_pies'].each do |pie|
          expect(@grandma.id).to eq pie['grandma_id']
          expect(pie['ingredients']).not_to be nil
        end
      end
    end
  end

  describe 'GET #show' do
    context 'html' do
      it 'renders the show template' do
        get :show, params: { id: pie.to_param }

        expect(response).to have_http_status :ok
        expect(response).to render_template(:show)

        expect(assigns(:mock_apple_pie)).not_to be nil
        expect(assigns(:mock_apple_pie)).to be_a MockApplePie
      end

      it 'renders not_found' do
        expect { get :show, params: { id: 555 } }.to raise_error(ActionController::RoutingError)
      end
    end

    context 'json' do
      it 'renders show JSON' do
        get :show, params: { id: pie.to_param }, format: :json

        response_body = JSON.parse(response.body)

        expect(response).to have_http_status :ok
        expect(response_body).to be_a Hash
        expect(response_body['mock_apple_pie']).to be_a Hash
        expect(response_body['mock_apple_pie']['grandma_id']).to eq @grandma.id
      end

      it 'renders not_found' do
        get :show, params: { id: 555 }, format: :json
        expect(response).to have_http_status :not_found
      end
    end
  end

  describe 'GET #new' do
    it 'renders the new template' do
      get :new

      expect(response).to have_http_status :ok
      expect(response).to render_template(:new)

      expect(assigns(:mock_apple_pie)).not_to be nil
      expect(assigns(:mock_apple_pie)).to be_a MockApplePie
    end
  end

  describe 'POST #create' do
    let(:new_attrs) { { mock_apple_pie: { ingredients: 'love', grandma_id: @grandma.id } } }
    let(:bad_attrs) { { mock_apple_pie: { ingredients: '', grandma_id: @grandma.id } } }

    context 'html' do
      it 'redirects to show' do
        post :create, params: new_attrs
        pie = MockApplePie.all.last
        expect(response).to have_http_status :redirect
        expect(response).to redirect_to(action: :show, id: pie.id)
      end

      it 'renders 422 for invalid args' do
        post :create, params: bad_attrs
        expect(response).to have_http_status :unprocessable_entity
      end
    end

    context 'json' do
      it 'creates successfully' do
        post :create, params: new_attrs.merge(format: :json)
        response_body = JSON.parse(response.body)

        expect(response).to have_http_status :created
        expect(response_body).to be_a Hash
        expect(response_body['mock_apple_pie']).to be_a Hash
        expect(response_body['mock_apple_pie']['grandma_id']).to eq @grandma.id
        expect(response_body['mock_apple_pie']['ingredients']).to eq new_attrs[:mock_apple_pie][:ingredients]
      end

      it 'renders 422 for invalid args' do
        post :create, params: bad_attrs.merge(format: :json)
        expect(response).to have_http_status :unprocessable_entity
      end
    end
  end

  describe 'GET #edit' do
    it 'renders the new template' do
      get :edit, params: { id: pie.to_param }

      expect(response).to have_http_status :ok
      expect(response).to render_template(:edit)

      expect(assigns(:mock_apple_pie)).not_to be nil
      expect(assigns(:mock_apple_pie)).to be_a MockApplePie
    end

    it 'renders not_found' do
      expect { get :edit, params: { id: 555 } }.to raise_error(ActionController::RoutingError)
    end
  end

  describe 'PUT #update' do
    let(:update_attrs) { { mock_apple_pie: { ingredients: 'lots of love' } } }
    let(:bad_attrs) { { mock_apple_pie: { ingredients: '' } } }

    context 'html' do
      it 'redirects to show' do
        put :update, params: update_attrs.merge(id: pie.to_param)
        expect(response).to have_http_status :redirect
        expect(response).to redirect_to(action: :show, id: pie.to_param)
      end

      it 'renders not_found' do
        expect { put :update, params: update_attrs.merge(id: 555) }.to raise_error(ActionController::RoutingError)
      end

      it 'renders unprocessable_entity' do
        put :update, params: bad_attrs.merge(id: pie.to_param)
        expect(response).to have_http_status :unprocessable_entity
      end
    end

    context 'json' do
      it 'updates successfully' do
        put :update, params: update_attrs.merge(id: pie.to_param, format: :json)
        response_body = JSON.parse(response.body)

        expect(response).to have_http_status :ok
        expect(response_body).to be_a Hash
        expect(response_body['mock_apple_pie']).to be_a Hash
        expect(response_body['mock_apple_pie']['ingredients']).to eq update_attrs[:mock_apple_pie][:ingredients]
      end

      it 'renders not_found' do
        put :update, params: update_attrs.merge(id: 555, format: :json)
        expect(response).to have_http_status :not_found
      end

      it 'renders unprocessable_entity' do
        put :update, params: bad_attrs.merge(id: pie.to_param, format: :json)
        expect(response).to have_http_status :unprocessable_entity
      end
    end
  end

  describe 'DELETE #destroy' do
    context 'html' do
      it 'redirects to index' do
        delete :destroy, params: { id: pie.to_param }
        expect(response).to have_http_status :redirect
        expect(response).to redirect_to(action: :index)
      end

      it 'renders not_found' do
        expect { delete :destroy, params: { id: 555 } }.to raise_error(ActionController::RoutingError)
      end

      it 'renders unprocessable_entity' do
        pie.update_attribute(:ingredients, 'real apples')

        delete :destroy, params: { id: pie.to_param }
        expect(response).to have_http_status :unprocessable_entity
      end
    end

    context 'json' do
      it 'deletes successfully' do
        delete :destroy, params: { id: pie.to_param }, format: :json
        expect(response).to have_http_status :no_content
        expect(response.body).to be_empty
      end

      it 'renders not_found' do
        delete :destroy, params: { id: 555 }, format: :json
        expect(response).to have_http_status :not_found
      end

      it 'renders unprocessable_entity' do
        pie.update_attribute(:ingredients, 'real apples')

        delete :destroy, params: { id: pie.to_param }, format: :json
        expect(response).to have_http_status :unprocessable_entity
      end
    end
  end
end
