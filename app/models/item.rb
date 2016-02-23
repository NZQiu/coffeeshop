class Item < ActiveRecord::Base
  belongs_to :drink

  validates :drink, presence: true

  extend Enumerize
  enumerize :sizes, in: ['tall', 'grande', 'venti']
end
