# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :price_range do
    retailer nil
    top_min_price "50.00"
    top_max_price "100.00"
    bottom_min_price "50.00"
    bottom_max_price "100.00"
    dress_min_price "50.00"
    dress_max_price "100.00"
  end
end
