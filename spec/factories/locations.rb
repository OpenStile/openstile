# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :location do
    locatable nil
    address "301 Water St. SE, Washington, DC 20003"
    short_title "Fashion Yards"
  end
end
