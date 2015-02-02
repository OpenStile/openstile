# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :retail_user do
    retailer
    sequence(:email)   { |i| "random.person#{i}@openstile.com" }
    password "example!"
    password_confirmation "example!"
    current_sign_in_at Time.now
    last_sign_in_at    Time.now
    current_sign_in_ip '127.0.0.1'
    last_sign_in_ip    '127.0.0.1'
  end
end
