# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :drop_in do
    retailer
    shopper
    time "2015-01-21 13:43:39"

    factory :drop_in_scheduled_in_the_next_hour do
      retailer
      shopper
      time { in_the_next_hour }
    end
  end
end
