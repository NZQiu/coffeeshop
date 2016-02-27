namespace :dev do
  desc 'generate seed data'
  task seed: :environment do
    ['Espresso', 'Latte', 'Cappuccino'].each do |coffee_name|
      drink = Drink.create drink_type: 'coffee', name: coffee_name

      ['Tall', 'Grande', 'Venti'].each do |size|
        item = Item.create drink: drink, cup_size: size.downcase, price: Random.rand(500)
      end
    end

    green_tea = Drink.create drink_type: 'tea', name: 'Green tea'
    ['Tall', 'Grande', 'Venti'].each do |size|
      Item.create drink: green_tea, cup_size: size.downcase, price: Random.rand(500)
    end

    hot_tea = Drink.create drink_type: 'tea', name: 'Hot tea'
    Item.create drink: hot_tea, cup_size: 'grande', price: 195

    puts "total #drinks: #{Drink.count}"
    puts "total #items: #{Item.count}"
  end
end
