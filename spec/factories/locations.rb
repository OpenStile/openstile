# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  sequence(:address){|n| "#{n} Water St. SE, Washington, DC 20003"}
  sequence(:neighborhood){|n| "Navy Yard #{n}"}
  factory :location do
    address
    neighborhood 
    short_title "Fashion Yards"
  end
end
