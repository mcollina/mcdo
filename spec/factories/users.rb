# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :user do
    email "hello@abcde.org"
    password "my_pass"
    password_confirmation "my_pass"
  end

  factory :invalid_user, :parent => :user do
    email ""
  end
end
