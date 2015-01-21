# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :drop_in_availability do
    retailer nil
    start_time "2015-01-20 21:34:33"
    end_time "2015-01-20 22:34:33"
    bandwidth 1
  end
end
