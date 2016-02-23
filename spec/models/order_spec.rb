require 'rails_helper'

describe Order do
  describe 'creation' do
    it 'must belongs to a item' do
      order = create :order
      expect(order.item).not_to be_nil

      order = build :order, item: nil
      expect(order.valid?).to be_falsy
    end

    it 'denies when item_id is invalid' do
      item = create :item

      order = build :order, item_id: item.id+1
      expect(order.valid?).to be_falsy
    end
  end

  it 'List all orders' do
    create_list :order, 5
    expect(Order.all.count).to eq 5
  end

  describe '#total_sales' do
    it 'calculates total sales of all orders' do
      item_1 = create :item, price: 100
      item_2 = create :item, price: 200
      item_3 = create :item, price: 300

      create :order, item: item_1
      create :order, item: item_2
      create_list :order, 2, item: item_3

      expect(Order.total_sales).to eq (100+200+2*300)
    end
  end
end
