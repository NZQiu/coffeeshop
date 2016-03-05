class Item < ActiveRecord::Base
  belongs_to :drink

  validates :drink, presence: true

  paginates_per 5
  
  extend Enumerize
  enumerize :cup_size, in: ['tall', 'grande', 'venti']
end
