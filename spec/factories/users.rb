FactoryGirl.define do
  factory :user do
    sequence(:email)   { |i| "random.person#{i}@sample.com" }
    first_name 'Jane'
    password 'example!'
    password_confirmation 'example!'
    current_sign_in_at Time.now
    last_sign_in_at    Time.now
    current_sign_in_ip '127.0.0.1'
    last_sign_in_ip    '127.0.0.1'

    factory :shopper_user do
      user_role FactoryGirl.create(:shopper_role)
    end

    factory :retailer_user do
      user_role FactoryGirl.create(:retailer_role)
      last_name 'Doe'
      retailer
    end

    factory :admin_user do
      user_role FactoryGirl.create(:admin_role)
    end
  end

end
