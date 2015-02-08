# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :image do
    name 'dc_washington_jacynthe_meadows_boutique'
    url "http://placehold.it/400x500"
    width 500
    height 500
    format 'jpg'
  end
end