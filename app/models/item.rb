class Item < ActiveRecord::Base
  belongs_to :drink

  validates :drink, presence: true

  extend Enumerize
  enumerize :cup_size, in: ['tall', 'grande', 'venti']

  def display_price
    "$#{"%.2f" % (price / 100.0)}"
  end
end
