# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :favorite do
    shopper nil
    favoriteable nil
  end
end
