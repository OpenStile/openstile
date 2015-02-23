# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :drop_in_availability do
    retailer nil
    template_date "2015-01-20"
    start_time "21:34:33"
    end_time "22:34:33"
    frequency "One-time"
    bandwidth 1
    location

    factory :standard_availability_for_tomorrow do
      template_date DateTime.current.advance(days: 1).to_date
      start_time "09:00:00 -0500"
      end_time "17:00:00 -0500"
      bandwidth 2
    end
  end
end
