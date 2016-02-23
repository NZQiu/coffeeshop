FactoryGirl.define do
  factory :drink do
    name { ['AAA', 'BBB', 'CCC'].sample }
    drink_type { ['coffee', 'tea'].sample }
  end
end
