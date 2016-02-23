class Order < ActiveRecord::Base
  belongs_to :item

  validates :item, presence: true

  scope :teas, -> { joins(:item, item: :drink).where('drinks.drink_type': 'tea') }
  scope :coffees, -> { joins(:item, item: :drink).where('drinks.drink_type': 'coffee') }

  def self.total_sales
    sum = 0
    Order.all.each { |order| sum += order.item.price }
    sum
  end

end
