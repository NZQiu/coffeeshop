require 'rails_helper'

describe Drink do
  describe '#coffees' do
    it 'returns an array of all coffee type drinks' do
      create_list :drink, 2, drink_type: 'coffee'

      expect(Drink.coffees.count).to eq 2
    end

  end

  describe '#teas' do
    it 'returns an array of all tea type drinks'

  end
end
