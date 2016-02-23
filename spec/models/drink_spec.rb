require 'rails_helper'

describe Drink do
  describe '#coffees' do
    it 'returns an array of all coffee type drinks' do
      create_list :drink, 2, drink_type: 'coffee'
      create_list :drink, 4, drink_type: 'tea'

      expect(Drink.coffees.count).to eq 2
    end

  end

  describe '#teas' do
    it 'returns an array of all tea type drinks' do
      create_list :drink, 2, drink_type: 'tea'

      expect(Drink.teas.count).to eq 2
    end
  end
end
