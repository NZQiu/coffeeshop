FactoryGirl.define do
  factory :item do
    association :drink, factory: :drink
    price { Random.rand(1000) }
    cup_size { ['tall', 'grande', 'venti'].sample }
  end
end
