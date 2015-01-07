# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :shopper do |f|
    f.first_name         Faker::Name.first_name
    f.sequence(:email)   { |i| "random.person#{i}@openstile.com" }
    f.password "example!"
    f.password_confirmation "example!"
    f.current_sign_in_at Time.now
    f.last_sign_in_at    Time.now
    f.current_sign_in_ip '127.0.0.1'
    f.last_sign_in_ip    '127.0.0.1'
  end
end
