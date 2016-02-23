class Order < ActiveRecord::Base
  belongs_to :item

  validates :item, presence: true
end
