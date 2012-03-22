# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :item do
    name "MyString"
    association :list
  end

  factory :invalid_item, parent: :item do
    name ""
  end
end
