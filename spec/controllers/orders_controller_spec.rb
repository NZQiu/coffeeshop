require 'rails_helper'

describe OrdersController do
  describe 'GET #index' do
    it 'lists all orders' do
      get :index

      expect(response).to be_success

      create_list :order, 3
      expect(assigns(:orders).count).to eq 3
    end
  end

  describe 'GET #listing' do
    it 'lists all orders' do
      get :listing

      expect(response).to be_success

      create_list :order, 3
      expect(assigns(:orders).count).to eq 3
    end

    it 'listing all coffee orders' do

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
