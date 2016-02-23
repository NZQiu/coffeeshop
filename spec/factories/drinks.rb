FactoryGirl.define do
  factory :drink do
    name { ['AAA', 'BBB', 'CCC'].sample }
    drink_type { ['coffee', 'tea'].sample }

    factory :tea do
      drink_type 'tea'
    end

    factory :coffee do
      drink_type 'coffee'
    end
  end
end
