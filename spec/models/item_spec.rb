require 'rails_helper'

describe Item do
  it 'must belongs to a drink' do
    item = create :item
    expect(item.drink).not_to be_nil

    item = build :item, drink: nil
    expect(item.valid?).to be_falsy
  end
end
