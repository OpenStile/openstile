FactoryGirl.define do
  factory :user_role do

    factory :shopper_role do
      name "SHOPPER"
      initialize_with { UserRole.find_or_create_by(name: name) }
    end

    factory :retailer_role do
      name "RETAILER"
      initialize_with { UserRole.find_or_create_by(name: name) }
    end

    factory :admin_role do
      name "ADMIN"
      initialize_with { UserRole.find_or_create_by(name: name) }
    end
  end

end