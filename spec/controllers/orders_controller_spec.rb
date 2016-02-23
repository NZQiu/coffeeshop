require 'rails_helper'

describe OrdersController do
  describe 'GET #index' do

  end

  describe 'GET #new' do
    it 'goes to order creation page' do
      get :new

      expect(response).to be_success
    end

    it 'builds a new order object' do
      get :new

      expect(assigns(:order).persisted?).to be_falsy
    end
  end

  describe 'POST #create' do
    it 'create a new order in database' do
      item = create :item
      expect { post :create, { order: { item_id: item.id } } }.to change(Order, :count).by 1
    end
  end

  describe 'GET #type' do
  end

  describe 'GET #size' do

  end
end
