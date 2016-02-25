FactoryGirl.define do
  factory :item do
    association :drink, factory: :drink
    price { Random.rand(1000) }
    cup_size { ['tall', 'grande', 'venti'].sample }

    factory :tall do
      cup_size 'tall'
    end

    factory :grande do
      cup_size 'grande'
    end

    factory :venti do
      cup_size 'venti'
    end

  end
end
