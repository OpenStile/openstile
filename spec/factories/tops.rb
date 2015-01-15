# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :top do
    name "Emerald Green Blouse"
    description "The perfect blouse for every ocassion"
    web_link "http://see-this-blouse.com"
    price 9.99
    retailer nil
  end
end
