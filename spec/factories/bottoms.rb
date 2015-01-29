# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :bottom do
    name "Sexy jeans"
    description "The perfect pair of skinny jeans"
    web_link "http://see-these-jeans.com"
    price 9.99
    retailer
  end
end
