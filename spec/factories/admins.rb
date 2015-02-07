# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :admin do
    sequence(:email)   { |i| "random.person#{i}@openstile.com" }
    password "example!"
    password_confirmation "example!"
  end
end
