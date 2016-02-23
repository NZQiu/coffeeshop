class Drink < ActiveRecord::Base
  extend Enumerize

  enumerize :drink_type, in: [:coffee, :tea]
  
  scope :coffees, -> { where drink_type: 'coffee' }
  scope :teas, -> { where drink_type: 'tea' }
end
