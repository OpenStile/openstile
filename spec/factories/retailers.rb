# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :retailer do
    name "Chic Boutique"
    description "Your one stop shop for all really cool dresses"
    location
    status 1
    owner_name 'Michelle Obama'
    phone_number '(202) 867-5309'
  end
end
