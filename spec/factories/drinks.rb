FactoryGirl.define do
  factory :drink do
    name { ['AAA', 'BBB', 'CCC'].sample }
    drink_type { ['Coffee', 'Tea'].sample }
  end
end
