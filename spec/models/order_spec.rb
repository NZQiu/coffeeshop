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
[]
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

  describe "#by_drink_type" do
    it 'return an array of all orders with specific drink type' do
      tea_item = create :item, drink: create(:tea)
      coffee_item = create :item, drink: create(:coffee)

      create_list :order, 3, item: tea_item
      create_list :order, 2, item: coffee_item

      expect(Order.by_drink_type('tea').count).to eq 3
    end

    it 'return an array of all orders with specific drink types and different cup size' do
      coffee_tall_item = create :item, cup_size: 'tall', drink: create(:coffee)
      coffee_venti_item = create :item, cup_size: 'venti', drink: create(:coffee)

      tea_item = create :item, drink: create(:tea)

      create :order, item: coffee_tall_item
      create :order, item: coffee_venti_item
      create_list :order, 3, item: tea_item

      expect(Order.by_drink_type('CoffeE').count).to eq 2
      expect(Order.by_drink_type('coffee').count).to eq 2
    end

    it 'reject invalid drink type' do
      expect(Order.by_drink_type('nothing')).to eq nil
      expect(Order.by_drink_type(nil)).to eq nil
    end

  end

  describe "#by_cup_size" do
    it 'return an array of all orders with specific cup size' do
      create_list :order, 2, item: create(:venti)
      create_list :order, 3, item: create(:tall)

      expect(Order.by_cup_size('Venti').count).to eq 2
    end

    it 'return an array of all orders with specific cup size and different drink types' do
      coffee_venti_item = create :item, cup_size: 'venti', drink: create(:coffee)
      tea_venti_item = create :item, cup_size: 'venti', drink: create(:tea)

      tall_item = create :item, cup_size: 'tall'

      create :order, item: coffee_venti_item
      create :order, item: tea_venti_item
      create_list :order, 3, item: tall_item

      expect(Order.by_cup_size('Venti').count).to eq 2
      expect(Order.by_cup_size('venti').count).to eq 2
    end

    it 'reject invalid cup size' do
      expect(Order.by_cup_size('nothing')).to eq nil
      expect(Order.by_cup_size(nil)).to eq nil
    end
  end

end
