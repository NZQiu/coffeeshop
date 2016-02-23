FactoryGirl.define do
  factory :item do
    association :drink, factory: :drink
    price { Rand(1000) }
    size { ['Tall', 'Grande', 'Venti'].sample }
  end
end
