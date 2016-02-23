FactoryGirl.define do
  factory :order do
    association :item, factory: :item
  end
end
