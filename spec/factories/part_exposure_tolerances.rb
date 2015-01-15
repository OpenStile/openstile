# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :part_exposure_tolerance do
    part nil
    style_profile nil
    tolerance 1
  end
end
