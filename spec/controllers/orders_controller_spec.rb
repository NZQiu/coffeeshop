require 'rails_helper'

describe OrdersController do
  describe 'GET #index' do
    it 'go to index page' do
      get :index

      expect(response).to be_success
    end
  end

  describe 'GET #listing' do
    it 'go to order listing page' do
      get :listing

      expect(response).to be_success
    end

    it 'list first 5 orders if more than 5' do
      get :listing

      create_list :order, 8
      expect(assigns(:orders).count).to eq 5
    end

    it 'list all orders if not more than 5' do
      get :listing

      expect(assigns(:orders).count).to eq 0
      
      create_list :order, 4
      expect(assigns(:orders).count).to eq 4
    end

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

end
