# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :look_tolerance do
    style_profile nil
    look nil
    tolerance 1
  end
end
