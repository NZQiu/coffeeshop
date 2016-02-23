class Order < ActiveRecord::Base
  belongs_to :item

  validates :item, presence: true

  def self.total_sales
    sum = 0
    Order.all.each { |order| sum += order.item.price }
    sum
  end
end
