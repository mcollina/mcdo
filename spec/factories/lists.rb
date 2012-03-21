# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :list do
    name "MyString"
  end

  factory :invalid_list, parent: :list do
    name ""
  end
end
