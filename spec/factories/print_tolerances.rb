# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :print_tolerance do
    style_profile nil
    print nil
    tolerance 1
  end
end
