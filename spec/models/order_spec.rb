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
end
