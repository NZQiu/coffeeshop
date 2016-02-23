class Item < ActiveRecord::Base
  belongs_to :drink

  validates :drink, presence: true
end
