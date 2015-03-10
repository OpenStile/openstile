module Callable
  extend ActiveSupport::Concern

  VALID_PHONE_NUMBER_REGEX = /\A\d{10,11}\z/

  included do
    include ActiveModel::Validations

    before_validation(on: :create) do
      phone_number.gsub!(/[^0-9]/, "") if attribute_present?("phone_number")
    end

    if self.inspect.include?('Retailer')
      validates :phone_number, presence: true, format: { with: VALID_PHONE_NUMBER_REGEX, message: "must be 10 or 11 numeric digits." }
    elsif self.inspect.include?('Shopper')
      validates :phone_number, presence: true, format: { with: VALID_PHONE_NUMBER_REGEX, message: "must be 10 or 11 numeric digits." },
                         unless: "phone_number.nil? or phone_number.empty?"
    end
  end
end
