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

  def self.by_drink_type(drink_type)
    return nil unless ['tea', 'coffee'].include?(drink_type && drink_type.downcase)

    joins(:item, item: :drink).where('drinks.drink_type': drink_type.downcase)
  end

  def self.by_cup_size(size)
    return nil unless Item.cup_size.values.include?(size && size.downcase)

    joins(:item).where('items.cup_size': size.downcase)
  end
end
