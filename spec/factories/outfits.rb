# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :outfit do
    name "Really cool shirt and pants"
    description "This awesome combo will make you stand out"
    price_description "Shirt - $50, Pants - $70"
    retailer nil
    look nil
    body_shape nil
    for_petite false
    for_tall false
    for_full_figured false
    top_fit nil
    bottom_fit nil
    average_price "60.00"
  end
end
