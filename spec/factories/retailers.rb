# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :retailer do
    name "Chic Boutique"
    description "Your one stop shop for all really cool dresses"
    quote 'Where affordability meets style'
    location
    size_range "00 (XS) - 14 (XL)"
    price_index 2
    status 1
  end
end
