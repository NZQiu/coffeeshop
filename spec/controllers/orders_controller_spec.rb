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
      create_list :order, 8

      get :listing
      expect(assigns(:orders).count).to eq 5

      get :listing, {page: 2}
      expect(assigns(:orders).count).to eq 3
    end

    it 'list all orders if not more than 5' do
      create_list :order, 4

      get :listing
      expect(assigns(:orders).count).to eq 4

      get :listing, {page: 2}
      expect(assigns(:orders).count).to eq 0
    end

    it 'listing orders with specific drink type' do
      tea_item = create :item, drink: create(:tea)
      coffee_item = create :item, drink: create(:coffee)

      create_list :order, 3, item: tea_item
      create_list :order, 2, item: coffee_item

      get :listing, {type: 'coffee'}
      expect(assigns(:orders).count).to eq 2

      get :listing, {type: 'CoffEE'}
      expect(assigns(:orders).count).to eq 2

      get :listing, {type: 'all'}
      expect(assigns(:orders).count).to eq 5
    end

    it 'listing orders with specific cup size' do
      create_list :order, 2, item: create(:venti)
      create_list :order, 3, item: create(:tall)

      get :listing, {size: 'venti'}
      expect(assigns(:orders).count).to eq 2

      get :listing, {size: 'VentI'}
      expect(assigns(:orders).count).to eq 2

      get :listing, {size: 'grande'}
      expect(assigns(:orders).count).to eq 0

      get :listing, {size: 'all'}
      expect(assigns(:orders).count).to eq 5
    end

    it 'listing orders with specific drink type and cup size' do
      coffee_venti_item = create :item, cup_size: 'venti', drink: create(:coffee)
      tea_venti_item = create :item, cup_size: 'venti', drink: create(:tea)
      coffee_grande_item = create :item, cup_size: 'grande', drink: create(:coffee)

      create_list :order, 2, item: coffee_venti_item
      create_list :order, 3, item: tea_venti_item
      create_list :order, 4, item: coffee_grande_item

      get :listing, {type: 'coffee', size: 'all'}
      expect(assigns(:orders).count).to eq 5

      get :listing, {type: 'all', size: 'venti'}
      expect(assigns(:orders).count).to eq 5

      get :listing, {type: 'coffee', size: 'venti'}
      expect(assigns(:orders).count).to eq 2

      get :listing, {type: 'tea', size: 'venti'}
      expect(assigns(:orders).count).to eq 3

      get :listing, {type: 'coffee', size: 'tall'}
      expect(assigns(:orders).count).to eq 0

    end

  end

  describe 'POST #create' do
    it 'create a new order in database' do
      item = create :item
      expect {
        xhr :post, :create, { id: item.id }
      }.to change(Order, :count).by(1)

      expect(response.status).to eq 201
      json = JSON.parse response.body
      expect(json['is_succ']).to eq(true)
      expect(json['msg']).to eq('Order successfully created.')
    end

    it 'reject new order creation in database' do
      item = create :item
      expect {
        xhr :post, :create, { id: item.id+1 }
      }.to change(Order, :count).by(0)

      expect(response.status).to eq 400
      json = JSON.parse response.body
      expect(json['is_succ']).to eq(false)
      expect(json['msg']).to eq('Order fail created!')
    end
  end

end
